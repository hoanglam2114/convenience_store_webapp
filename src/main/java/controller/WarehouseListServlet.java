package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Warehouse;

import java.io.IOException;
import java.util.List;
import dao.WarehouseDAO;

/**
 * @author hoang on 6/21/2025-1:31 AM
 * IntelliJ IDEA
 */
@WebServlet(name = "WarehouseListServlet", urlPatterns = {"/list-warehouse"})
public class WarehouseListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        String status = req.getParameter("status");

        WarehouseDAO warehouseDAO = new WarehouseDAO();
        List<Warehouse> list;

        if ((search == null || search.trim().isEmpty()) && (status == null || status.trim().isEmpty())) {
            // Không search, không filter → lấy tất cả
            list = warehouseDAO.getAllWarehouses();
        } else {
            // Có search hoặc filter → lọc theo điều kiện
            list = warehouseDAO.searchAndFilter(search, status);
        }

        req.setAttribute("list", list);
        req.getRequestDispatcher("/view/list-warehouse.jsp").forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}