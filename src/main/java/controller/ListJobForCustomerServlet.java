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
import java.util.List;
import model.Job;
import model.JobCategories;
import model.JobLocation;
import model.JobTypes;

/**
 *
 * @author admin
 */
public class ListJobForCustomerServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListJobForCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListJobForCustomerServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        JobDAO p = new JobDAO();
        List<Job> list = p.getAllJob();
        session.setAttribute("job", list);

        List<JobLocation> joblocate = p.getAllJobLocation();
        session.setAttribute("joblocate", joblocate);

        List<JobTypes> jobtype = p.getAllTypes();
        session.setAttribute("jobtype", jobtype);

        request.getRequestDispatcher("/view/job.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        JobDAO jd = new JobDAO();
        String title = request.getParameter("jobTitle");
        String joblocation_raw = request.getParameter("jobLocation");
        String jobtype_raw = request.getParameter("jobType");

        Integer joblocation = ( joblocation_raw.equalsIgnoreCase("All location"))
                ? null : Integer.parseInt(joblocation_raw);

        Integer jobtype = (jobtype_raw.equalsIgnoreCase("All Type"))
                ? null : Integer.parseInt(jobtype_raw);

        List<Job> filterjob = jd.filterJobsCustomer(title, jobtype, joblocation);
        session.setAttribute("job", filterjob);
        request.getRequestDispatcher("/view/job.jsp").forward(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
