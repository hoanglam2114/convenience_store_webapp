package controller;

import dao.InventoryDAO;
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

import model.*;

/**
 * @author hoang on 6/8/2025-2:39 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "ImportProductServlet", urlPatterns = {"/import-product"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ImportProductServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ImportProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id_raw = request.getParameter("inventory_id");
        int id;
        InventoryDAO inventoryd = new InventoryDAO();
        try {
            id = Integer.parseInt(id_raw);
            Inventory inven = inventoryd.getInventoryById(id);
            session.setAttribute("inventory", inven);
            request.getRequestDispatcher("/view/import-product.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appPath = request.getServletContext().getRealPath("");
        File projectRoot = new File(appPath).getParentFile().getParentFile();
        String savePath = projectRoot.getAbsolutePath() + File.separator + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "product";

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

        String id_raw = request.getParameter("idPro");
        String cate_raw = request.getParameter("catePro");
        String name = request.getParameter("namePro");
        String barcode = request.getParameter("barcode");
        String price_raw = request.getParameter("pricePro");
        String unit_raw = request.getParameter("unitPro");
        String supplier_raw = request.getParameter("supPro");

        if (expirationDate.isBefore(manufactureDate)) {
            request.setAttribute("errorDate", "Ngày hết hạn phải sau ngày sản xuất.");
            request.getRequestDispatcher("/view/import-product.jsp").forward(request, response);
        } else if (expirationDate.isBefore(currentDate)) {
            request.setAttribute("errorDate", "Ngày hết hạn phải sau ngày hiện tại.");
            request.getRequestDispatcher("/view/import-product.jsp").forward(request, response);
        } else {
            ProductsDAO pd = new ProductsDAO();
            int id = Integer.parseInt(id_raw);
            Products p1 = pd.getProductById(id);
            String img = (fileName != null && !fileName.isEmpty()) ? fileName : p1.getImage();
            SuppliersDAO sd = new SuppliersDAO();
            WeightUnitDAO wud = new WeightUnitDAO();
            ProductCategoriesDAO pcd = new ProductCategoriesDAO();

            int latestBatch = pd.getLatestBatchByName(name);
            int newBatch = latestBatch + 1;

            int cate = Integer.parseInt(cate_raw);
            ProductCategories ci = pcd.getCategoryById(cate);

            int unit = Integer.parseInt(unit_raw);
            WeightUnit ui = wud.getUnitById(unit);

            int sup = Integer.parseInt(supplier_raw);
            Suppliers si = sd.getSupById(sup);

            float price = Float.parseFloat(price_raw);

            Products pNew = new Products(name, price, img, barcode, ci, si, ui);
            pd.insertPro(pNew);
            response.sendRedirect("import-to-inventory");
        }
    }
}
