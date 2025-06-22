package controller;

import dao.WarehouseDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-6:00 PM
 * IntelliJ IDEA
 */
@WebServlet("/delete-warehouse")
public class DeleteWarehouseServlet extends HttpServlet {

    private final WarehouseDAO warehouseDAO = new WarehouseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int warehouseID = Integer.parseInt(request.getParameter("warehouse_id"));

            boolean success = warehouseDAO.deleteWarehouseByID(warehouseID);

            if (success) {
                response.sendRedirect("list-warehouse");
            } else {
                request.setAttribute("errorMessage", "Không thể xoá kho.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

