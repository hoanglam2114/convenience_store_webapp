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
import java.util.List;
import model.Job;
import model.JobCategories;
import model.JobLocation;
import model.JobTypes;

/**
 *
 * @author admin
 */
public class ListJobServlet extends HttpServlet {

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
            out.println("<title>Servlet ListJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListJobServlet at " + request.getContextPath() + "</h1>");
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
        String indexPage = request.getParameter("index");
        int currentPage = 1;
        if (indexPage != null) {
            try {
                currentPage = Integer.parseInt(indexPage);
            } catch (NumberFormatException e) {
            }
        } else {
            indexPage = "1";
        }

        int index = Integer.parseInt(indexPage);
        JobDAO dao = new JobDAO();
        int count = dao.getTotalJob();
        int endPage = count / 5;
        if (count % 5 != 0) {
            endPage++;
        }
        List<Job> list = dao.pagingJobs(index);

        List<JobTypes> jt = dao.getAllTypes();
        session.setAttribute("jobtypes", jt);

        List<JobCategories> jc = dao.getAllJobCategories();
        session.setAttribute("jobcate", jc);

        List<JobLocation> jl = dao.getAllJobLocation();
        session.setAttribute("joblocation", jl);

        List<String> status = dao.getStatuses();
        session.setAttribute("statuses", status);

        request.setAttribute("currentPage", currentPage);
        session.setAttribute("job", list);
        request.setAttribute("endPage", endPage);
        request.getRequestDispatcher("/view/List-job.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
