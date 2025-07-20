package controller;

import dao.PostDAO;
import dao.PostSectionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customers;
import model.Post;
import model.PostSection;
import model.Tag;

public class CustomerEditPostServlet extends HttpServlet {

    private final PostDAO postDAO = new PostDAO();
    private final PostSectionDAO sectionDAO = new PostSectionDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerEditPostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerEditPostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("id"));

        Post post = postDAO.getPostById(postId);
        List<PostSection> sections = sectionDAO.getSectionsByPostId(postId);
        List<Tag> allTags = postDAO.getAllTags();
        List<Integer> selectedTags = postDAO.getTagIdsByPostId(postId);

        request.setAttribute("post", post);
        request.setAttribute("sections", sections);
        request.setAttribute("tagList", allTags);
        request.setAttribute("selectedTags", selectedTags);
        request.setAttribute("mode", "edit");
        
        request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int postId = Integer.parseInt(request.getParameter("postId"));
        String title = request.getParameter("title");
        String status = request.getParameter("status");

        String[] tagIds = request.getParameterValues("tagIds");
        String[] sectionTitles = request.getParameterValues("sectionTitles");
        String[] sectionContents = request.getParameterValues("sectionContents");

        // 1. Cập nhật bài viết
        postDAO.updatePost(postId, title, status);

        // 2. Cập nhật lại tags
        postDAO.clearTagsByPostId(postId);
        if (tagIds != null) {
            for (String tagIdStr : tagIds) {
                int tagId = Integer.parseInt(tagIdStr);
                postDAO.linkPostWithTag(postId, tagId);
            }
        }

        // 3. Cập nhật lại section
        sectionDAO.deleteSectionsByPostId(postId);
        if (sectionTitles != null && sectionContents != null) {
            for (int i = 0; i < sectionTitles.length; i++) {
                PostSection section = new PostSection();
                section.setPostId(postId);
                section.setSectionTitle(sectionTitles[i]);
                section.setSectionContent(sectionContents[i]);
                section.setSectionHtml(null); // nếu bạn không dùng html riêng thì để null
                section.setSectionImageUrl(null); // có thể dùng sau nếu có ảnh
                section.setSortOrder(i + 1);
                sectionDAO.insertSection(section);
            }
        }

        // 4. Quay về danh sách
        response.sendRedirect("customer-manage-posts");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
