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
import java.util.List;
import model.WeightUnit;

/**
 *
 * @author admin
 */
public class AddUnitServlet extends HttpServlet {

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
            out.println("<title>Servlet AddUnitServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUnitServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/AddUnit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        WeightUnitDAO wud = new WeightUnitDAO();
        String name = request.getParameter("nameUnit");
        try {
     
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
                request.setAttribute("unitName", name);
                request.getRequestDispatcher("/view/AddUnit.jsp").forward(request, response);
                return;
            }
            WeightUnit unitNew = new WeightUnit(name);
            wud.insertUnit(unitNew);
            response.sendRedirect("ListUnit");

        } catch (NumberFormatException e) {
            System.out.println(e);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
