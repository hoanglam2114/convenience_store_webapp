package controller;

import dao.PostDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Post;

public class AdminPostManagementServlet extends HttpServlet {

    private static final int POSTS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận các tham số lọc
        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim();
        }

        String status = request.getParameter("status");
        if (status != null) {
            status = status.trim();
        }

        String startDateStr = request.getParameter("startDate");
        if (startDateStr != null) {
            startDateStr = startDateStr.trim();
        }

        String endDateStr = request.getParameter("endDate");
        if (endDateStr != null) {
            endDateStr = endDateStr.trim();
        }
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        // Chuyển đổi ngày
        Date startDate = parseDate(startDateStr);
        Date endDate = parseDate(endDateStr);

        int offset = (page - 1) * POSTS_PER_PAGE;

        // Gọi DAO lấy dữ liệu
        PostDAO dao = new PostDAO();
        List<Post> postList = dao.searchPosts(keyword, status, startDate, endDate, offset, POSTS_PER_PAGE);
        int totalPosts = dao.countFilteredPosts(keyword, status, startDate, endDate);
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        // Gửi dữ liệu sang JSP
        request.setAttribute("postList", postList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPosts", totalPosts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("postsPerPage", POSTS_PER_PAGE);
        request.getRequestDispatcher("view/admin-manage-posts.jsp").forward(request, response);
    }

    private Date parseDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        try {
            java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            return new Date(utilDate.getTime());
        } catch (ParseException e) {
            return null;
        }
    }

    // Không cần xử lý POST ở đây
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý bài viết bởi admin, hỗ trợ lọc và phân trang.";
    }
}
