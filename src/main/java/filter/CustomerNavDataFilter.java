package filter;

/**
 * @author hoang on 7/16/2025-4:14 PM
 * IntelliJ IDEA
 */

import dao.ProductCategoriesDAO;
import dao.CategoryGroupDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class CustomerNavDataFilter implements Filter {
    private CategoryGroupDAO groupDAO;
    private ProductCategoriesDAO categoryDAO;

    @Override
    public void init(FilterConfig filterConfig) {
        groupDAO = new CategoryGroupDAO();
        categoryDAO = new ProductCategoriesDAO();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (request instanceof HttpServletRequest) {
            HttpServletRequest req = (HttpServletRequest) request;
            String uri = req.getRequestURI();

            // Chỉ load nếu là trang customer
            if (uri.contains("/customer-")) {
                HttpSession session = req.getSession();
                if (session.getAttribute("categoryGroups") == null || session.getAttribute("categories") == null) {
                    session.setAttribute("categoryGroups", groupDAO.getAllGroups());
                    session.setAttribute("categories", categoryDAO.getAllCategoriesWithGroup());
                    System.out.println("NavBar data loaded for: " + uri);
                }
            }
        }
        chain.doFilter(request, response);
    }
}