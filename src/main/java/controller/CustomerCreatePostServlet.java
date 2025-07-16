package controller;

import dao.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import model.Post;

@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // max 5MB
public class CustomerCreatePostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerCreatePostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerCreatePostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String tagString = request.getParameter("tags[]"); // từ JS: "tag1,tag2"
        String[] tags = tagString != null ? tagString.split(",") : new String[0];
        Part imagePart = request.getPart("featuredImage");

        // Lấy file name từ ảnh
        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

        // Đường dẫn lưu ảnh bền vững (VD: D:/xinxo-blog-uploads/)
        String uploadPath = System.getProperty("user.home") + File.separator + "xinxo-blog-uploads";

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // tạo nếu chưa có
        }
        // Lưu ảnh vào thư mục
        File imageFile = new File(uploadPath + File.separator + fileName);
        imagePart.write(imageFile.getAbsolutePath());

        // Lưu post vào DB
        int userId = (int) request.getSession().getAttribute("userId");
        PostDAO dao = new PostDAO();
        Post post = new Post();
        post.setTitle(title);
        post.setContent(content);
        post.setUserId(userId);
        post.setStatus("pending");

        int postId = dao.insertPost(post);
        dao.insertPostImage(postId, fileName);

        for (String tag : tags) {
            dao.insertTagIfNotExists(tag.trim(), postId);
        }

        // Chuyển hướng
        response.sendRedirect("blog?success=1");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
