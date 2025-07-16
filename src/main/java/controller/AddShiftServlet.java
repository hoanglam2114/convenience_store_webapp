/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.ShiftDAO;
import model.Shift;
import java.io.IOException;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author nguye
 */
@WebServlet(name = "AddShiftServlet", urlPatterns = {"/AddShiftServlet"})
public class AddShiftServlet extends HttpServlet {

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
            out.println("<title>Servlet AddShiftServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddShiftServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/shift-add.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final ShiftDAO shiftDAO = new ShiftDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            addShift(request, response);
        } else {
            response.sendRedirect("shiftList");
        }
    }

    private void addShift(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String name = request.getParameter("shiftName");
            LocalTime startTime = LocalTime.parse(request.getParameter("startTime"));
            LocalTime endTime = LocalTime.parse(request.getParameter("endTime"));
            String[] daysArray = request.getParameterValues("workingDays");
            String description = request.getParameter("description");

            List<String> workingDays = (daysArray != null) ? Arrays.asList(daysArray) : List.of();

            Shift shift = new Shift();
            shift.setShiftName(name);
            shift.setStartTime(startTime);
            shift.setEndTime(endTime);
            shift.setWorkingDays(workingDays);
            shift.setDescription(description);

            long duration = ChronoUnit.MINUTES.between(startTime, endTime);
            if (duration <= 0) {
                duration += 24 * 60; // xử lý ca đêm
            }
            if (duration > 12 * 60) {
                request.setAttribute("error", "Thời lượng ca làm không được vượt quá 12 tiếng.");
                request.setAttribute("shiftName", name);
                request.setAttribute("startTime", request.getParameter("startTime"));
                request.setAttribute("endTime", request.getParameter("endTime"));
                request.setAttribute("selectedDays", workingDays);
                request.setAttribute("description", description);
                request.getRequestDispatcher("view/shift-add.jsp").forward(request, response);
                return;
            }

            if (!name.matches("[\\p{L}\\d\\s]+")) {
                request.setAttribute("error", "Tên ca không được chứa ký tự đặc biệt.");
                request.setAttribute("shiftName", name);
                request.setAttribute("startTime", request.getParameter("startTime"));
                request.setAttribute("endTime", request.getParameter("endTime"));
                request.setAttribute("selectedDays", workingDays);
                request.setAttribute("description", description);
                request.getRequestDispatcher("view/shift-add.jsp").forward(request, response);
                return;
            }

            if (shiftDAO.isOverlappingShift(shift)) {
                request.setAttribute("error", "Ca làm bị trùng với ca đã có trong cùng ngày.");
                request.setAttribute("shiftName", name);
                request.setAttribute("startTime", request.getParameter("startTime"));
                request.setAttribute("endTime", request.getParameter("endTime"));
                request.setAttribute("selectedDays", workingDays);
                request.setAttribute("description", description);
                request.getRequestDispatcher("view/shift-add.jsp").forward(request, response);
                return;
            }

            boolean success = shiftDAO.addShift(shift);
            if (success) {
                request.setAttribute("success", "Tạo ca làm thành công!");
            } else {
                request.setAttribute("error", "Tạo ca làm thất bại!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }

//        request.getRequestDispatcher("ListShift").forward(request, response);
        response.sendRedirect("ListShift");
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
