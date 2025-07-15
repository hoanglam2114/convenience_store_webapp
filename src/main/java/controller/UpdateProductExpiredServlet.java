/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DiscountProductDAO;
import dao.ProductsDAO;
import dao.StoreStockDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.DiscountProduct;
import model.Products;

/**
 *
 * @author admin
 */
public class UpdateProductExpiredServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateProductExpiredServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProductExpiredServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id_raw = request.getParameter("product_id");
        int id;
        ProductsDAO pd = new ProductsDAO();
        try {
            id = Integer.parseInt(id_raw);
            Products p = pd.getProductById(id);
            session.setAttribute("productExpired", p);
            request.getRequestDispatcher("/view/update-expired.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idPro"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        StoreStockDAO ss = new StoreStockDAO();
        ProductsDAO pd = new ProductsDAO();
        Products p = pd.getProductById(id);
        double newPrice =  (p.getPrice() * (1 - discount/100));
        DiscountProduct discountProduct = new DiscountProduct(id, newPrice);
        DiscountProductDAO discountProductDAO = new DiscountProductDAO();
        if (discountProductDAO.isProductExists(id)) {
            discountProductDAO.updateProduct(discountProduct);
        } else {
            discountProductDAO.insertPro(discountProduct);
            ss.updateStore();
        }

        response.sendRedirect("ProductDiscount");
        
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
