/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.JobApplicationDAO;
import dao.JobDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.JobApplications;

/**
 *
 * @author admin
 */
public class ListJobApplicationServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ListJobApplicationServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListJobApplicationServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

  
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
        JobApplicationDAO dao = new JobApplicationDAO();
        int count = dao.getTotalJobApplications();
        int endPage = count / 5;
        if (count % 5 != 0) {
            endPage++;
        }
        List<JobApplications> list = dao.pagingJobsApplications(index);


        request.setAttribute("currentPage", currentPage);
        session.setAttribute("job", list);
        request.setAttribute("endPage", endPage);
        
        
        request.getRequestDispatcher("/view/list-job-review.jsp").forward(request, response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
