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
import model.ProductCategories;

/**
 *
 * @author admin
 */
public class UpdateCategoriesServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet UpdateCategoriesServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCategoriesServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id_raw = request.getParameter("cateId");
        int id;
        ProductCategoriesDAO pcd = new ProductCategoriesDAO();
        try{
           id = Integer.parseInt(id_raw);
           ProductCategories pc = pcd.getCategoryById(id);
           session.setAttribute("cate", pc );
           request.getRequestDispatcher("/view/category-update.jsp").forward(request, response);
        }catch(NumberFormatException e){
            System.out.println(e);
        }
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        String id_raw = request.getParameter("cateid");
        String name = request.getParameter("catename");
        ProductCategoriesDAO pcd = new ProductCategoriesDAO();
        int id ;
        try{    
            id = Integer.parseInt(id_raw);
            ProductCategories pc = new ProductCategories(id, name);
            pcd.updateCategory(pc);
            response.sendRedirect("ListCate");
        }catch(NumberFormatException e){
            System.out.println(e);
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
