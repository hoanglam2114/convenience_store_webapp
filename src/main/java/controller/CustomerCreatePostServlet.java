package controller;

import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customers;
import model.Post;
import model.PostSection;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CustomerCreatePostServlet", urlPatterns = {"/customer-create-post"})
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB
public class CustomerCreatePostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer-login");
            return;
        }

        PostDAO dao = new PostDAO();
        request.setAttribute("tagList", dao.getAllTags());
        request.setAttribute("loggedInCustomer", customer);
        request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
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

        // Tạo tên file duy nhất
        String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
        String uniqueFileName = System.currentTimeMillis() + extension;

        // Đường dẫn lưu ảnh
        String uploadPath = getServletContext().getRealPath("/") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File imageFile = new File(uploadPath, uniqueFileName);
        imagePart.write(imageFile.getAbsolutePath());

        // Tạo bài viết
        HttpSession session = request.getSession();
        Customers customer = (Customers) session.getAttribute("customer");
        if (customer == null) {
            response.sendRedirect("customer-login");
            return;
        }

        PostDAO dao = new PostDAO();
        Post post = new Post();
        post.setTitle(title);
        post.setContent(content);
        post.setUserId(customer.getId()); // đảm bảo lấy đúng customer ID
        post.setStatus("pending");

        int postId = dao.insertPost(post);
        if (postId <= 0) {
            request.setAttribute("error", "Không thể tạo bài viết.");
            request.getRequestDispatcher("view/customer-create-post.jsp").forward(request, response);
            return;
        }

        dao.insertPostImage(postId, uniqueFileName); // chỉ lưu tên ảnh

        // Gắn tag
        if (tagIdParams != null) {
            for (String tagIdStr : tagIdParams) {
                try {
                    int tagId = Integer.parseInt(tagIdStr);
                    dao.linkPostWithTag(postId, tagId);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid tag ID: " + tagIdStr);
                }
            }
        }

        // Xử lý ảnh cho section
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

                    File secFile = new File(uploadPath, secUniqueName);
                    imagePartSec.write(secFile.getAbsolutePath());

                    sectionImageUrl = "uploads/" + secUniqueName;
                }

                PostSection section = new PostSection();
                section.setPostId(postId);
                section.setSectionTitle(secTitle);
                section.setSectionContent(secContent);
                section.setSectionImageUrl(sectionImageUrl.isEmpty() ? null : sectionImageUrl);
                section.setSortOrder(i + 1);

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
