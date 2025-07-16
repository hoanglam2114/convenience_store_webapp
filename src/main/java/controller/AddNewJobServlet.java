/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.JobDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import model.Job;
import model.JobCategories;
import model.JobLocation;
import model.JobTypes;

/**
 *
 * @author admin
 */
public class AddNewJobServlet extends HttpServlet {

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
            out.println("<title>Servlet AddNewJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddNewJobServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        JobDAO jd = new JobDAO();
        List<JobTypes> jt = jd.getAllTypes();
        session.setAttribute("jobtypes", jt);

        List<JobCategories> jc = jd.getAllJobCategories();
        session.setAttribute("jobcate", jc);

        List<JobLocation> jl = jd.getAllJobLocation();
        session.setAttribute("joblocation", jl);
        
        List<String>status = jd.getStatuses();
        session.setAttribute("statuses", status);

        request.getRequestDispatcher("/view/add-job.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JobDAO jd = new JobDAO();
        String jobtype_raw = request.getParameter("jobtype");
        String title = request.getParameter("title").trim();
        String description = request.getParameter("description").trim();
        String location_raw = request.getParameter("location");
        String jobcate_raw = request.getParameter("jobcate");
        String deadline_raw = request.getParameter("deadline");
        String status = request.getParameter("status");
        
        
        
        
        int jobtype = Integer.parseInt(jobtype_raw);
        JobTypes jt = jd.getTypesById(jobtype);
        int location = Integer.parseInt(location_raw);
        JobLocation jl = jd.getJobLocationById(location);
        int jobcate = Integer.parseInt(jobcate_raw);
        JobCategories jc = jd.getJobCategoriesById(jobcate);
        
        LocalDate deadline = LocalDate.parse(deadline_raw);
        LocalDateTime createdAt = LocalDateTime.now();
        
         LocalDate currentDate = LocalDate.now();
        
        boolean hasError = false;

        // Validate mã khuyến mãi
        if (title.startsWith(" ") || title.length() > 40 || !title.matches("^[\\p{L}0-9 ]+$")) {
            request.setAttribute("errorTitle", "Tên công việc không hợp lệ. Không bắt đầu bằng dấu cách, không vượt quá 40 ký tự và không chứa ký tự đặc biệt.");
            hasError = true;
        }

        if ((description.startsWith(" ") || description.length() > 300)) {
            request.setAttribute("errorDes", "Miêu tả không hợp lệ. Không bắt đầu bằng dấu cách, không vượt quá 40 ký tự và không chứa ký tự đặc biệt.");
            hasError = true;
        }

         // Trả về nếu có lỗi
        if (hasError) {
            request.getRequestDispatcher("/view/add-job.jsp").forward(request, response);
            return;
        }
        
        if (deadline.isBefore(currentDate)) {
            request.setAttribute("errorMessage", "Ngày ứng tuyển nộp hồ sơ phải sau ngày hiện tại.");
            request.getRequestDispatcher("/view/add-job.jsp").forward(request, response);
        }else{
        Job job = new Job(title, jt, jl, deadline,
                createdAt, jc, description, status);
        jd.insertJob(job);
        response.sendRedirect("ListJob");
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
