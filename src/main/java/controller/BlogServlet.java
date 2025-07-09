
package controller;

import dao.PostDAO;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;
import jakarta.servlet.*;
import java.io.IOException;
import java.util.*;

public class BlogServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Bài viết nổi bật
        PostDAO postDAO = new PostDAO();
        
        Post featuredPost = postDAO.getFeaturedPost();
        if (featuredPost != null) {
            String featuredImage = postDAO.getFirstImageByPostId(featuredPost.getId());
            String featuredTag = postDAO.getPrimaryTagNameByPostId(featuredPost.getId());
            request.setAttribute("featuredPost", featuredPost);
            request.setAttribute("featuredImage", featuredImage);
            request.setAttribute("featuredTag", featuredTag);
        }

        // Danh sách bài viết mới
        List<Post> latestPosts = postDAO.getLatestPosts(6);
        List<Map<String, Object>> postData = new ArrayList<>();
        List<Map<String, Object>> tags = postDAO.getPopularTags();

        for (Post post : latestPosts) {
            Map<String, Object> item = new HashMap<>();
            item.put("post", post);
            item.put("image", postDAO.getFirstImageByPostId(post.getId()));
            item.put("tag", postDAO.getPrimaryTagNameByPostId(post.getId()));
            postData.add(item);
        }

        request.setAttribute("latestPosts", postData);
        request.setAttribute("tags", tags);

        // Forward sang JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("view/customer-blog.jsp");
        dispatcher.forward(request, response);
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
