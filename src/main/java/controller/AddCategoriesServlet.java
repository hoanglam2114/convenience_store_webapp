/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductCategoriesDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.ProductCategories;

/**
 *
 * @author admin
 */
public class AddCategoriesServlet extends HttpServlet {

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
            out.println("<title>Servlet AddCategoriesServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCategoriesServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/view/category-add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ProductCategoriesDAO pcd = new ProductCategoriesDAO();
        String name = request.getParameter("nameCate");

        try {
         
           String msg = "";

            // Validate ký tự đặc biệt
            if (name == null || !name.matches("^[a-zA-Z0-9À-ỹ\\s]+$")) {
                msg = "Tên loại sản phẩm không được chứa ký tự đặc biệt!";
            }else if(name.startsWith(" ")){
                msg = "Tên loại sản phẩm không được bắt đầu bằng khoảng cách!";
            }else if(name.length()>40){
                msg = "Tên loại sản phẩm không được quá 40 kí tự!";
            } else {
                // Kiểm tra trùng tên với đơn vị khác (khác ID)
                List<ProductCategories> list = pcd.getAll();
                for (ProductCategories productCategories : list) {
                    if (name.equalsIgnoreCase(productCategories.getName())) {
                        msg = "Tên loại sản phẩm đã tồn tại!";
                        break;
                    }
                }
            }

            // Nếu có lỗi, trả về giao diện cập nhật
            if (!msg.isEmpty()) {
                request.setAttribute("error", msg);
                request.setAttribute("cateName", name);
                request.getRequestDispatcher("/view/category-add.jsp").forward(request, response);
                return;
            }
            
  
            
                ProductCategories cateNew = new ProductCategories(name);
                pcd.insertCategory(cateNew);
                response.sendRedirect("ListCate");
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
