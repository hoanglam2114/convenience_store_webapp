package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Customers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

/**
 * @author hoang on 6/22/2025-10:02 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "EditProfileServlet", urlPatterns = {"/edit-profile"})
@MultipartConfig
public class EditCustomerProfile extends HttpServlet {

    private final CustomerDAO customersDAO = new CustomerDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");

            String gender = request.getParameter("gender");
            if (gender == null || gender.trim().isEmpty()) {
                gender = "Chưa xác định";
            }

            // Lấy file ảnh từ form
            Part filePart = request.getPart("avatar");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            String avatarPath = null; // Mặc định là null

            if (fileName != null && !fileName.trim().isEmpty()) {
                String projectRoot = System.getProperty("user.dir");
                String uploadDir = projectRoot + File.separator + "uploads" + File.separator + "avatars";

                File uploadFolder = new File(uploadDir);
                if (!uploadFolder.exists()) {
                    uploadFolder.mkdirs();
                }

                String uniqueFileName = id + "_" + System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadDir + File.separator + uniqueFileName);

                avatarPath = "avatars/" + uniqueFileName; // Chỉ set nếu thực sự có ảnh
            }


            // Validate name
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tên không được để trống.");
                request.getRequestDispatcher("/view/customer-profile.jsp").forward(request, response);
                return;
            }

            // Cập nhật vào DB
            boolean updated = customersDAO.editCustomerById(id, name, gender, avatarPath);

            if (updated) {
                // Cập nhật lại session
                Customers customer = customersDAO.getCustomerById(id);
                request.getSession().setAttribute("customer", customer);

                response.sendRedirect("customer-profile?updated=1");
            } else {
                request.setAttribute("errorMessage", "Cập nhật thất bại.");
                request.getRequestDispatcher("/view/customer-profile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi cập nhật: " + e.getMessage());
            request.getRequestDispatcher("/view/customer-profile.jsp").forward(request, response);
        }
    }
}

