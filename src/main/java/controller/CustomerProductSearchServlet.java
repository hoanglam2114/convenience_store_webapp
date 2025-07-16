package controller;

import dao.ProductsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Products;

import java.io.IOException;
import java.util.List;

/**
 * @author hoang on 7/16/2025-7:46 PM
 * IntelliJ IDEA
 */
@WebServlet("/customer-product-search")
public class CustomerProductSearchServlet extends HttpServlet {
    private ProductsDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("categoryId");
        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException ignored) {}
        }

        List<Products> products = productDAO.searchProducts(keyword, categoryId);

        request.setAttribute("products", products);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryId);

        request.getRequestDispatcher("/view/customer-product-search.jsp").forward(request, response);
    }
}