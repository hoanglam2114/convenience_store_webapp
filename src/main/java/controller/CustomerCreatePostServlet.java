package controller;

import dao.PostDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.stream.Collectors;
import java.util.List;
import model.Post;
import model.PostSection;

@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // max 5MB
public class CustomerCreatePostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PostDAO dao = new PostDAO();
        request.setAttribute("tagList", dao.getAllTags()); // Gửi danh sách tag sang JSP
        request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        System.out.println("===> Tạo bài viết mới: " + title);
        String[] tagIdParams = request.getParameterValues("tagIds");
        String[] sectionTitles = request.getParameterValues("sectionTitles");
        String[] sectionContents = request.getParameterValues("sectionContents");

        Part imagePart = request.getPart("featuredImage");
        Collection<Part> parts = request.getParts();

        if (title == null || content == null || imagePart == null || imagePart.getSize() == 0) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin và chọn ảnh.");
            request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
            return;
        }

        // Tạo tên file duy nhất cho ảnh đại diện
        String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String uniqueFileName = System.currentTimeMillis() + extension;

        // Đường dẫn lưu ảnh
        String uploadPath = System.getProperty("user.home") + File.separator + "xinxo-blog-uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File imageFile = new File(uploadPath + File.separator + uniqueFileName);
        imagePart.write(imageFile.getAbsolutePath());

        // Tạo bài viết
        int userId = 1; // Lấy từ session nếu có
        PostDAO dao = new PostDAO();
        Post post = new Post();
        post.setTitle(title);
        post.setContent(content);
        post.setUserId(userId);
        post.setStatus("pending");

        int postId = dao.insertPost(post);
        System.out.println("Post ID returned = " + postId);
        if (postId <= 0) {
            request.setAttribute("error", "Không thể tạo bài viết. Hãy kiểm tra dữ liệu đầu vào hoặc kết nối database.");
            request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
            return;
        }
        dao.insertPostImage(postId, uniqueFileName);

        // Gom tất cả section images
        List<Part> sectionImageParts = parts.stream()
                .filter(p -> "sectionImages".equals(p.getName()) && p.getSize() > 0)
                .collect(Collectors.toList());

        if (sectionContents != null) {
            for (int i = 0; i < sectionContents.length; i++) {
                String secTitle = (sectionTitles != null && sectionTitles.length > i) ? sectionTitles[i] : "";
                String secContent = sectionContents[i];
                String sectionImageUrl = "";

                if (i < sectionImageParts.size()) {
                    Part imagePartSec = sectionImageParts.get(i);
                    String secFileName = Paths.get(imagePartSec.getSubmittedFileName()).getFileName().toString();
                    String secExt = secFileName.substring(secFileName.lastIndexOf("."));
                    String secUniqueName = "section_" + System.currentTimeMillis() + "_" + i + secExt;

                    File secFile = new File(uploadPath + File.separator + secUniqueName);
                    imagePartSec.write(secFile.getAbsolutePath());

                    sectionImageUrl = "image/" + secUniqueName;
                }

                PostSection section = new PostSection();
                section.setPostId(postId);
                section.setSectionTitle(secTitle);
                section.setSectionContent(secContent);
                section.setSectionImageUrl(sectionImageUrl.isEmpty() ? null : sectionImageUrl);
                section.setSortOrder(i + 1);
                System.out.println("PostID mới là: " + postId);
                System.out.println("Đang lưu image chính: " + uniqueFileName);
                System.out.println("Section " + i + ": title=" + sectionTitles + ", img=" + sectionImageUrl);
                dao.insertPostSection(section);
            }
        }
        response.sendRedirect("blog?success=1");
    }

    @Override
    public String getServletInfo() {
        return "Customer creates blog post with selected tags and image upload";
    }
}
