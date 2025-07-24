package controller;

import dao.CustomerDAO;
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
            out.println("<h1>Servlet BlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Bài viết nổi bật
        PostDAO postDAO = new PostDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        // ===== Lấy bài viết nổi bật =====
        Post featuredPost = postDAO.getFeaturedPost();
        if (featuredPost != null) {
            String featuredImage = postDAO.getFirstImageByPostId(featuredPost.getId());
            String featuredTag = postDAO.getPrimaryTagNameByPostId(featuredPost.getId());
            request.setAttribute("featuredPost", featuredPost);
            request.setAttribute("featuredImage", featuredImage);
            request.setAttribute("featuredTag", featuredTag);
        }

        // ===== Xử lý phân trang =====
        int pageSize = 2;
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }

        int totalPosts = postDAO.countApprovedPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        int offset = (page - 1) * pageSize;

        List<Post> paginatedPosts = postDAO.getApprovedPostsPaginated(offset, pageSize);
        List<Map<String, Object>> postData = new ArrayList<>();
        for (Post post : paginatedPosts) {
            Map<String, Object> item = new HashMap<>();
            item.put("post", post);
            item.put("image", postDAO.getFirstImageByPostId(post.getId()));
            item.put("tag", postDAO.getPrimaryTagNameByPostId(post.getId()));
            postData.add(item);
        }

        // ===== Các tag phổ biến =====
        List<Map<String, Object>> tags = postDAO.getPopularTags();

        // ===== Truyền thông tin khách hàng từ session (nếu đã đăng nhập) =====
        // Giả sử session có object tên "customer" kiểu model.Customer
        Object customer = request.getSession().getAttribute("customer");
        if (customer != null) {
            request.setAttribute("loggedInCustomer", customer);
        }

        // ===== Truyền dữ liệu sang view =====
        request.setAttribute("latestPosts", postData);
        request.setAttribute("tags", tags);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // ===== Forward sang JSP =====
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
