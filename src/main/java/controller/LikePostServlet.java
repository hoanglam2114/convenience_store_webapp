/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DBContext;
import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import model.Customers;

/**
 *
 * @author Admin
 */
public class LikePostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LikePostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LikePostServlet at " + request.getContextPath() + "</h1>");
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

        HttpSession session = request.getSession();

        // Giả lập người dùng nếu chưa có đăng nhập (chỉ dùng khi TEST)
        Customers currentUser = (Customers) session.getAttribute("currentUser");
        if (currentUser == null) {
            currentUser = new Customers();
            currentUser.setId(1); // ID người dùng phải tồn tại trong DB
            currentUser.setName("User Test");
            session.setAttribute("currentUser", currentUser);
        }

        int userId = currentUser.getId();
        int postId = Integer.parseInt(request.getParameter("post_id"));

        try {
            PostDAO postDAO = new PostDAO();

            if (!postDAO.hasUserLiked(postId, userId)) {
                postDAO.addLike(postId, userId);
            }

            response.sendRedirect("post-detail?id=" + postId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi xử lý lượt thích.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
