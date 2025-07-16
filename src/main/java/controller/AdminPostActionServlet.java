/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class AdminPostActionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminPostActionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminPostActionServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int postId = Integer.parseInt(request.getParameter("postId"));

        String newStatus = "PENDING";
        if ("approve".equalsIgnoreCase(action)) {
            newStatus = "APPROVED";
        } else if ("reject".equalsIgnoreCase(action)) {
            newStatus = "REJECTED";
        }

        PostDAO dao = new PostDAO();
        dao.updatePostStatus(postId, newStatus);

        response.sendRedirect("admin-manage-posts"); // redirect về danh sách bài viết
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
