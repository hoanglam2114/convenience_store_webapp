package controller;

import dao.StoreStockDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.StoreStock;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author hoang on 6/8/2025-10:43 AM
 * IntelliJ IDEA
 */
@WebServlet(name = "ListStoreStockServlet", urlPatterns = {"/list-store-stock"})
public class ListStoreStockServlet extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListStoreStockServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListStoreStockServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        StoreStockDAO ss = new StoreStockDAO();
        List<StoreStock> list = ss.getAllStoreStock();
        session.setAttribute("store", list);
        request.getRequestDispatcher("/view/list-store-stock.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests if necessary
        processRequest(request, response);
    }
}
