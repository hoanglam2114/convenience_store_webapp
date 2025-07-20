/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EmailTemplateDAO;
import dao.JobApplicationDAO;
import dao.JobDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.DistrictApply;
import model.EmailTemplate;
import model.Gender;
import model.JobApplications;
import model.JobDetail;
import model.SourceAds;
import verify.SendEmail;

/**
 *
 * @author admin
 */
public class AddJobCustomerServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddJobCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddJobCustomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        JobApplicationDAO jd = new JobApplicationDAO();
        JobDAO jobdao = new JobDAO();
        String job_id = request.getParameter("job_id");

        List<JobDetail> jobtext_detail = jobdao.getJobDetailTextById(Integer.parseInt(job_id));

        for (JobDetail jobDetail : jobtext_detail) {
            String[] contentList = jobDetail.getTextcontent().split("\\.");
            jobDetail.setContentList(contentList);
        }
        session.setAttribute("jobtext", jobtext_detail);

        List<Gender> gender = jd.getAllGenders();
        session.setAttribute("gender", gender);

        List<DistrictApply> district = jd.getAllDistricts();
        session.setAttribute("district", district);

        List<SourceAds> source = jd.getAllSourceAds();
        session.setAttribute("source", source);

        request.getRequestDispatcher("/view/job-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender_raw = request.getParameter("gender");
        String dateofbirth_raw = request.getParameter("dateofbirth");
        String address = request.getParameter("address");
        String district_raw = request.getParameter("district");
        String interviewdate_raw = request.getParameter("interviewdate");
        String source_raw = request.getParameter("source");

        JobApplicationDAO jad = new JobApplicationDAO();

        int gender = Integer.parseInt(gender_raw);
        Gender gd = jad.getGenderById(gender);

        int district = Integer.parseInt(district_raw);
        DistrictApply da = jad.getDistrictById(district);

        int source = Integer.parseInt(source_raw);
        SourceAds sa = jad.getSourcesById(source);

        LocalDate dateofbirth = LocalDate.parse(dateofbirth_raw);
        LocalDate interviewdate = LocalDate.parse(interviewdate_raw);

        boolean hasError = false;

// Validate Họ và tên
        if (name == null || name.trim().isEmpty() || name.length() > 50) {
            request.setAttribute("errorName", "Họ và tên không được để trống và không vượt quá 50 ký tự.");
            hasError = true;
        }

// Validate Email
        if (email == null || email.trim().isEmpty() || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
            request.setAttribute("errorEmail", "Email không hợp lệ.");
            hasError = true;
        }

// Validate Số điện thoại
        if (phone == null || phone.trim().isEmpty() || !phone.matches("^0\\d{8,10}$")) {
            request.setAttribute("errorPhone", "Số điện thoại không hợp lệ (phải từ 9–11 chữ số và bắt đầu bằng số 0).");
            hasError = true;
        }



// Validate Ngày sinh     
        try {
            dateofbirth = LocalDate.parse(dateofbirth_raw); // yyyy-MM-dd
            if (dateofbirth.isAfter(LocalDate.now().minusYears(18))) {
                request.setAttribute("errorDOB", "Ngày sinh không hợp lệ (phải lớn hơn 18 tuổi).");
                hasError = true;
            }
        } catch (Exception e) {
            request.setAttribute("errorDOB", "Định dạng ngày sinh không hợp lệ.");
            hasError = true;
        }

// Validate Địa chỉ hiện tại
        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("errorAddress", "Vui lòng nhập địa chỉ hiện tại.");
            hasError = true;
        }


// Validate Ngày phỏng vấn
 
        try {
            interviewdate = LocalDate.parse(interviewdate_raw);
            DayOfWeek day = interviewdate.getDayOfWeek();
            if (day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY) {
                request.setAttribute("errorInterviewDate", "Vui lòng chọn ngày trong tuần (không phải thứ 7, CN).");
                hasError = true;
            } else if (interviewdate.isBefore(LocalDate.now())) {
                request.setAttribute("errorInterviewDate", "Ngày phỏng vấn phải lớn hơn hoặc bằng hôm nay.");
                hasError = true;
            }
        } catch (Exception e) {
            request.setAttribute("errorInterviewDate", "Định dạng ngày phỏng vấn không hợp lệ.");
            hasError = true;
        }



// Nếu có lỗi -> quay lại form
        if (hasError) {
            request.getRequestDispatcher("/view/job-detail.jsp").forward(request, response);
            return;
        }


        JobApplications ja = new JobApplications(name, email, phone, dateofbirth,
                gd, address, da, interviewdate, sa);

        jad.insertJobApplication(ja);

        EmailTemplateDAO templateDAO = new EmailTemplateDAO();

        EmailTemplate template = null;
        try {
            template = templateDAO.getTemplateByName("Recruitment Thank You Template");
        } catch (SQLException ex) {
            Logger.getLogger(AddJobCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (template != null) {
            String content = template.getContent()
                    .replace("{{email}}", email);
            SendEmail se = new SendEmail();
            se.send(email, template.getSubject(), content);
        }

        response.sendRedirect("ListJobCustomer");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
