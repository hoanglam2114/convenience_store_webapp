package controller;

import dao.CategoryGroupDAO;
import dao.ProductCategoriesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CategoryGroup;
import model.ProductCategories;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

/**
 * @author hoang on 7/16/2025-4:04 PM
 * IntelliJ IDEA
 */
@WebServlet("/load-categories")
public class LoadCategoriesServlet extends HttpServlet {
    private CategoryGroupDAO groupDAO;
    private ProductCategoriesDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        groupDAO = new CategoryGroupDAO();
        categoryDAO = new ProductCategoriesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Load dữ liệu nếu chưa có trong session
        if (session.getAttribute("categoryGroups") == null || session.getAttribute("categories") == null) {
            List<CategoryGroup> categoryGroups = groupDAO.getAllGroups();
            List<ProductCategories> categories = categoryDAO.getAllCategoriesWithGroup();

            System.out.println("Category Groups size: " + categoryGroups.size());
            System.out.println("Categories size: " + categories.size());

            session.setAttribute("categoryGroups", categoryGroups);
            session.setAttribute("categories", categories);
        }

        request.getRequestDispatcher("/view/customer-home.jsp").forward(request, response);
    }
}