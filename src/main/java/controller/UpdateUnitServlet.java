/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.WeightUnitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.WeightUnit;

/**
 *
 * @author admin
 */
public class UpdateUnitServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateUnitServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUnitServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String id_raw = request.getParameter("weight_unit_id");
        int id;
        WeightUnitDAO wud = new WeightUnitDAO();
        try {
            id = Integer.parseInt(id_raw);
            WeightUnit wu = wud.getUnitById(id);
            session.setAttribute("unit", wu);
            request.getRequestDispatcher("/view/UpdateUnit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_raw = request.getParameter("unitId");
        String name = request.getParameter("unitName");
        int id;
        WeightUnitDAO wud = new WeightUnitDAO();

        try {
            id = Integer.parseInt(id_raw);
            String msg = "";

            // Validate ký tự đặc biệt
            if (name == null || !name.matches("^[a-zA-Z0-9À-ỹ\\s]+$")) {
                msg = "Tên đơn vị không được chứa ký tự đặc biệt!";
            } else {
                // Kiểm tra trùng tên với đơn vị khác (khác ID)
                List<WeightUnit> list = wud.getAll();
                for (WeightUnit weightUnit : list) {
                    if (name.equalsIgnoreCase(weightUnit.getName())) {
                        msg = "Tên đơn vị đã tồn tại!";
                        break;
                    }
                }
            }

            // Nếu có lỗi, trả về giao diện cập nhật
            if (!msg.isEmpty()) {
                request.setAttribute("error", msg);
                request.setAttribute("unitId", id);
                request.setAttribute("unitName", name);
                request.getRequestDispatcher("/view/UpdateUnit.jsp").forward(request, response);
                return;
            }
            WeightUnit wu = new WeightUnit(id, name);
            wud.updateCategory(wu);
            response.sendRedirect("ListUnit");

        } catch (NullPointerException e) {
            System.out.println(e);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
