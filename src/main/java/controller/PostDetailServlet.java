package controller;

import dao.PostDAO;
import dao.PostSectionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;
import model.PostSection;

public class PostDetailServlet extends HttpServlet {

    private PostDAO postDAO;
    private PostSectionDAO postSectionDAO;

    @Override
    public void init() {
        postDAO = new PostDAO();
        postSectionDAO = new PostSectionDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("blog"); // Redirect nếu không có ID
            return;
        }

        try {
            int postId = Integer.parseInt(idParam);

            Post post = postDAO.getPostById(postId);
            if (post == null) {
                response.sendRedirect("blog"); // Không tìm thấy post
                return;
            }

            List<PostSection> sections = postSectionDAO.getSectionsByPostId(postId);

            request.setAttribute("post", post);
            request.setAttribute("sections", sections);

            request.getRequestDispatcher("view/customer-post-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("blog"); // ID không hợp lệ
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
