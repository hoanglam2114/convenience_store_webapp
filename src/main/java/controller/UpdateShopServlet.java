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
import java.util.List;
import model.Shop;

/**
 *
 * @author admin
 */
@WebServlet("/updateShop")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UpdateShopServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateShopServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateShopServlet at " + request.getContextPath() + "</h1>");
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
        String id_raw = request.getParameter("shop_id");
        ShopDAO sd = new ShopDAO();
        int id;
        try {
            id = Integer.parseInt(id_raw);
            Shop s = sd.getShopId(id);
            session.setAttribute("Shop", s);
            request.getRequestDispatcher("/view/update-shop.jsp").
                    forward(request, response);
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
//        File projectRoot = new File(appPath).getParentFile().getParentFile();
//        String savePath = projectRoot.getAbsolutePath() + File.separator + "web" + File.separator + "assets" + File.separator + "images" + File.separator + "product";

        String savePath = request.getServletContext().getRealPath("/assets/img/shop");
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        String fileName = null;
        for (Part part : request.getParts()) {
            if (part.getName().equals("shopImage")) {
                fileName = extractFileName(part);
                if (fileName != null && !fileName.isEmpty()) {
                    part.write(savePath + File.separator + fileName);
                    request.setAttribute("message", savePath + File.separator + fileName);
                }
            }
        }

        System.out.println("Uploaded file name: " + fileName);


        ShopDAO sd = new ShopDAO();
        String id_raw = request.getParameter("shopId");
        String name = request.getParameter("shopName");
        String address = request.getParameter("shopAddress");
        String phone = request.getParameter("shopPhone");
        String email = request.getParameter("shopEmail").trim();
        String openHours = request.getParameter("shopOpenHours");





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

        if (!openHours.equals(openHours.trim()) || openHours.startsWith(" ") || openHours.length() > 50) {
            request.setAttribute("errorStoreHours", "Giờ mở cửa không được bắt đầu bằng dấu cách và tối đa 50 ký tự.");
            hasError = true;
        }

        // Trả về nếu có lỗi
        if (hasError) {
            request.getRequestDispatcher("/view/update-shop.jsp").forward(request, response);
            return;
        }



        int id = Integer.parseInt(id_raw);
        Shop s1 = sd.getShopId(id);
        String img = (fileName != null && !fileName.isEmpty()) ? fileName : s1.getShopLogo();


        Shop newShop = new Shop(id, name, address, phone,
                email, openHours, img);

        sd.updateShop(newShop);
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