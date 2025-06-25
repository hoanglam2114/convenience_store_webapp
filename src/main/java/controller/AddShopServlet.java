/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ShopDAO;
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

/**
 *
 * @author admin
 */
@WebServlet("/addShop")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddShopServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddShopServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddShopServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/page-add-shop.jsp").forward(request, response);
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
        String savePath = request.getServletContext().getRealPath("/assets/img/shop");

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

        HttpSession session = request.getSession();
        ShopDAO sd = new ShopDAO();
        String name = request.getParameter("storeName");
        String phone = request.getParameter("storePhone");
        String address = request.getParameter("storeAddress");
        String email = request.getParameter("storeEmail").trim();
        String opening = request.getParameter("storeHours");

        String img = (fileName != null && !fileName.isEmpty()) ? fileName : null;

        boolean hasError = false;

        // Validate sđt
        if (!phone.equals(phone.trim()) || !phone.matches("\\d{10}")) {
            request.setAttribute("errorStorePhone", "số điện thoại chỉ được nhập chữ số và không quá 10 chữ số.");
            hasError = true;
        }

        // Validate tên cửa hàng
        if (!name.equals(name.trim()) ||  name.startsWith(" ") || name.length() > 40 || !name.matches("^[\\p{L}0-9 ]+$")) {
            request.setAttribute("errorStoreName", "Tên cửa hàng không hợp lệ. Không bắt đầu bằng dấu cách, không vượt quá 40 ký tự và không chứa ký tự đặc biệt.");
            hasError = true;
        }

        // Validate địa chỉ
        if (!address.equals(address.trim()) || address.startsWith(" ") || address.length() > 50) {
            request.setAttribute("errorStoreAddress", "Địa chỉ cửa hàng không được bắt đầu bằng dấu cách và tối đa 50 ký tự.");
            hasError = true;
        }

        if (email.startsWith(" ") || email.length() > 50) {
            request.setAttribute("errorStoreEmail", "Email không được bắt đầu bằng dấu cách và tối đa 50 ký tự.");
            hasError = true;
        }

        if (!opening.equals(opening.trim()) || opening.startsWith(" ") || opening.length() > 50) {
            request.setAttribute("errorStoreHours", "Giờ mở cửa không được bắt đầu bằng dấu cách và tối đa 50 ký tự.");
            hasError = true;
        }

        // Trả về nếu có lỗi
        if (hasError) {
            request.getRequestDispatcher("/view/page-add-shop.jsp").forward(request, response);
            return;
        }

        sd.insertShop(name, address, phone, email, opening, img);
        response.sendRedirect("ListShop");

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}