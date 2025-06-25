/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import dao.SuppliersDAO;
import dao.WeightUnitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.util.List;
import model.ProductCategories;
import model.Products;
import model.Suppliers;
import model.WeightUnit;

/**
 *
 * @author admin
 */
@WebServlet("/addPro")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddProductsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProducts</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProducts at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductCategoriesDAO pd = new ProductCategoriesDAO();
        List<ProductCategories> cate = pd.getAll();
        session.setAttribute("cate", cate);

        WeightUnitDAO wd = new WeightUnitDAO();
        List<WeightUnit> unit = wd.getAll();
        session.setAttribute("unit", unit);

        SuppliersDAO sd = new SuppliersDAO();
        List<Suppliers> sup = sd.getAll();
        session.setAttribute("sup", sup);

        request.getRequestDispatcher("/view/AddProduct.jsp").
                forward(request, response);

    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appPath = request.getServletContext().getRealPath("");
//        File projectRoot = new File(appPath).getParentFile().getParentFile();
//        String savePath = projectRoot.getAbsolutePath() + File.separator + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "product";
        String savePath = request.getServletContext().getRealPath("/assets/img/product");

        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        String fileName = null;
        for (Part part : request.getParts()) {
            fileName = extractFileName(part);
            if (fileName != null && !fileName.isEmpty()) {
                part.write(savePath + File.separator + fileName);
                request.setAttribute("message", savePath + File.separator + fileName);
            }
        }

        String manufactureDateStr = request.getParameter("manufactureDate");
        String expirationDateStr = request.getParameter("expirationDate");

        LocalDate manufactureDate = LocalDate.parse(manufactureDateStr);
        LocalDate expirationDate = LocalDate.parse(expirationDateStr);
        LocalDate currentDate = LocalDate.now();

        String catePro = request.getParameter("catePro");
        String barcode = request.getParameter("barcode");
        String namePro = request.getParameter("namePro");
        String unitPro = request.getParameter("unitPro");
        String pricePro = request.getParameter("pricePro");
        String suppPro = request.getParameter("suppPro");

        
        String img = (fileName != null && !fileName.isEmpty()) ? fileName : null;

        ProductsDAO pd = new ProductsDAO();
        SuppliersDAO sd = new SuppliersDAO();
        WeightUnitDAO wud = new WeightUnitDAO();
        ProductCategoriesDAO pcd = new ProductCategoriesDAO();

        boolean hasError = false;

        if (pd.isBarcodeExists(barcode)) {
            request.setAttribute("errorbarcode", "Mã vạch đã tồn tại trong hệ thống.");
            hasError = true;
        }

        // Validate barcode
        if (!barcode.matches("\\d+")) {
            request.setAttribute("errorbarcode", "Mã vạch chỉ được chứa chữ số.");
            hasError = true;
        }

        // Validate tên sản phẩm
        if (namePro.startsWith(" ") || namePro.length() > 40 || !namePro.matches("^[\\p{L}0-9 ]+$")) {
            request.setAttribute("errornamePro", "Tên sản phẩm không hợp lệ. Không bắt đầu bằng dấu cách, không vượt quá 40 ký tự và không chứa ký tự đặc biệt.");
            hasError = true;
        }

        // Validate giá tiền
        try {
           int price = Integer.parseInt(pricePro);
            if (price < 0) {
                request.setAttribute("errorpricePro", "Giá tiền không được âm.");
                hasError = true;
            } else if (price > 100000000) {
                request.setAttribute("errorpricePro", "Giá tiền không được vượt quá 100 triệu.");
                hasError = true;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorpricePro", "Giá tiền phải là số nguyên.");
            hasError = true;
        }

        // Trả về nếu có lỗi
        if (hasError) {
            request.getRequestDispatcher("/view/AddProduct.jsp").forward(request, response);
            return;
        }

        if (expirationDate.isBefore(manufactureDate)) {
            request.setAttribute("errorMessage", "Ngày hết hạn phải sau ngày sản xuất.");
            request.getRequestDispatcher("/view/AddProduct.jsp").forward(request, response);
        } else if (expirationDate.isBefore(currentDate)) {
            request.setAttribute("errorMessage", "Ngày hết hạn phải sau ngày hiện tại.");
            request.getRequestDispatcher("/view/AddProduct.jsp").forward(request, response);
        } else {
            Products s = pd.getProductByName(namePro);
            if (s == null) {
                int cate = Integer.parseInt(catePro);
                ProductCategories ci = pcd.getCategoryById(cate);
                int unit = Integer.parseInt(unitPro);
                WeightUnit wu = wud.getUnitById(unit);
                int supp = Integer.parseInt(suppPro);
                Suppliers su = sd.getSupById(supp);
                int price = Integer.parseInt(pricePro);
                int batch = 1;
                Products pNew = new Products(namePro, price, img, barcode,
                        ci, su, wu, manufactureDate, expirationDate, batch);
                pd.insertPro(pNew);
                response.sendRedirect("ListProduct");
            } else {
                int latest_batch = pd.getLatestBatchByName(namePro);
                int new_batch = latest_batch + 1;
                int price = Integer.parseInt(pricePro);
                int cate = Integer.parseInt(catePro);
                ProductCategories ci = pcd.getCategoryById(cate);
                int unit = Integer.parseInt(unitPro);
                WeightUnit wu = wud.getUnitById(unit);
                int supp = Integer.parseInt(suppPro);
                Suppliers su = sd.getSupById(supp);

                Products pNew = new Products(namePro, price, img, barcode,
                        ci, su, wu, manufactureDate, expirationDate, new_batch);
                pd.insertPro(pNew);
                response.sendRedirect("ListProduct");

            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
