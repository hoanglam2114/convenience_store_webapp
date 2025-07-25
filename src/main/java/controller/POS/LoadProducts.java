package controller.POS;

import dao.EmployeeDAO;
import dao.ProductCategoriesDAO;
import dao.PromotionDAO;
import dao.StoreStockDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import model.Cart;
import model.Employees;
import model.ProductCategories;
import model.Promotion;
import model.StoreStock;

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
        HttpSession session = request.getSession();
        StoreStockDAO stockDAO = new StoreStockDAO();
        ProductCategoriesDAO catDAO = new ProductCategoriesDAO();

        PromotionDAO promoDAO = new PromotionDAO();
        List<Promotion> activePromos = promoDAO.getActivePromotions();
        if (!activePromos.isEmpty()) {
            Promotion p = activePromos.get(0); 
            session.setAttribute("autoPromotion", p);
            session.setAttribute("autoPromotionDiscount", p.getDiscount_value());
        }

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

        String customerName = (String) session.getAttribute("name");
        String customerPhone = (String) session.getAttribute("phone");
        Accounts staff = (Accounts) session.getAttribute("account");
        if (staff != null) {
            request.setAttribute("staff", staff);

            EmployeeDAO employeeDAO = new EmployeeDAO();
            Employees emp = employeeDAO.getEmployeeByAccountId(staff.getAccount_id());

            if (emp != null) {
                request.setAttribute("employee", emp);
                session.setAttribute("employee_id", emp.getId());
            }
        }
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            request.setAttribute("cart", cart);
        }

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
