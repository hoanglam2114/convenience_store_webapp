package controller.POS;

import dao.CustomerDAO;
import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customers;
import model.Products;

/**
 *
 * @author Admin
 */
public class LoadProducts extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoadProducts</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadProducts at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductsDAO productDAO = new ProductsDAO();
        ProductCategoriesDAO categoryDAO = new ProductCategoriesDAO();

        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("categoryId");

        List<Products> listProducts;

        if (keyword != null && !keyword.trim().isEmpty()) {
            listProducts = productDAO.searchProductByName(keyword);
        } else if (categoryIdStr != null) {
            int categoryId = Integer.parseInt(categoryIdStr);
            listProducts = productDAO.getProductsByCategory(categoryId);
        } else {
            listProducts = productDAO.getAllProduct();
        }

        request.setAttribute("listProducts", listProducts);
        request.setAttribute("listCategories", categoryDAO.getAll());

        // Lấy thông tin khách hàng từ session
        HttpSession session = request.getSession();
        request.setAttribute("phone", session.getAttribute("phone"));
        request.setAttribute("name", session.getAttribute("name"));

        request.getRequestDispatcher("/view/pos-home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
