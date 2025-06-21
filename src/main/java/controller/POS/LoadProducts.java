package controller.POS;

import dao.CustomerDAO;
import dao.ProductCategoriesDAO;
import dao.ProductsDAO;
import dao.StoreStockDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;
import model.Cart;
import model.Customers;
import model.ProductCategories;
import model.Products;
import model.StoreStock;

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

        StoreStockDAO stockDAO = new StoreStockDAO();
        ProductCategoriesDAO catDAO = new ProductCategoriesDAO();

        List<ProductCategories> listCategories = catDAO.getAll();
        request.setAttribute("listCategories", listCategories);

        String categoryIdRaw = request.getParameter("categoryId");
        List<StoreStock> listStocks;

        if (categoryIdRaw != null && !categoryIdRaw.isEmpty()) {
            int categoryId = Integer.parseInt(categoryIdRaw);
            listStocks = stockDAO.getInStockByCategory(categoryId);
            request.setAttribute("selectedCategoryId", categoryId);
        } else {
            listStocks = stockDAO.getAllInStock();
        }

        request.setAttribute("listStocks", listStocks);

        HttpSession session = request.getSession();
        String customerName = (String) session.getAttribute("name");
        String customerPhone = (String) session.getAttribute("phone");
        Cart cart = (Cart) session.getAttribute("cart");

        if (customerName != null) request.setAttribute("name", customerName);
        if (customerPhone != null) request.setAttribute("phone", customerPhone);
        if (cart != null) request.setAttribute("cart", cart);

        request.getRequestDispatcher("view/pos-home.jsp").forward(request, response);
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
