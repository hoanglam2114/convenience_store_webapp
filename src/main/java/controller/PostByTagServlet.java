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
import java.util.List;
import java.util.Map;

public class PostByTagServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostByTagServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostByTagServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            String sortParam = request.getParameter("sort");
            if (sortParam == null) {
                sortParam = "newest"; 
            }

            List<Map<String, Object>> posts;
            String tagName;

            if (idParam == null || idParam.isEmpty()) {
                posts = postDAO.getLatestPostsAsMap(sortParam); 
                tagName = "Tất cả";
            } else {
                int tagId = Integer.parseInt(idParam);
                tagName = postDAO.getTagNameById(tagId);
                posts = postDAO.getPostsByTagId(tagId, sortParam); 
            }

            List<Map<String, Object>> tags = postDAO.getPopularTags();

            request.setAttribute("tagName", tagName);
            request.setAttribute("posts", posts);
            request.setAttribute("tags", tags);
            request.setAttribute("sort", sortParam);

            request.getRequestDispatcher("view/customer-posts-by-tag.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi xử lý tag.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
