package controller;

import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ProductCategories;
import model.Products;

import java.io.IOException;
import java.util.List;

/**
 * @author hoang on 6/22/2025-8:26 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "CustomerHomeServlet", urlPatterns = "/customer-home")
public class CustomerHomeServlet extends HttpServlet {
    private final ProductsDAO productsDAO = new ProductsDAO();
    private final ProductCategoriesDAO productCategoriesDAO = new ProductCategoriesDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        List<Products> products = productsDAO.getAllProduct();
        List<ProductCategories> categories = productCategoriesDAO.getAll();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/view/customer-home.jsp").forward(request, response);
    }
}
