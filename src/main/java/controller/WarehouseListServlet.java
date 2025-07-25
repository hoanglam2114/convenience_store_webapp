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
        String pageParam = req.getParameter("page");

        int page = 1;
        int pageSize = 3;

        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int offset = (page - 1) * pageSize;

        WarehouseDAO warehouseDAO = new WarehouseDAO();
        List<Warehouse> list;
        int totalWarehouses;

        if ((search == null || search.trim().isEmpty()) && (status == null || status.trim().isEmpty())) {
            list = warehouseDAO.getWarehousesPaging(offset, pageSize);
            totalWarehouses = warehouseDAO.countAll();
        } else {
            list = warehouseDAO.searchAndFilterPaging(search, status, offset, pageSize);
            totalWarehouses = warehouseDAO.countFiltered(search, status);
        }

        int totalPages = (int) Math.ceil((double) totalWarehouses / pageSize);

        req.setAttribute("list", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("search", search);
        req.setAttribute("status", status);

        req.getRequestDispatcher("/view/list-warehouse.jsp").forward(req, resp);
    }
}