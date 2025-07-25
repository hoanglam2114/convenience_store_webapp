package filter;

/**
 * @author hoang on 7/19/2025-9:47 PM
 * IntelliJ IDEA
 */
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import model.Accounts;

@WebFilter("/*")
public class AccessFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String uri = request.getRequestURI();
        String context = request.getContextPath();

        System.out.println("AccessFilter - URI: " + uri);

        // Bỏ qua luồng customer (không check login admin/staff)
            if (uri.contains("/customer-") ||
                    uri.contains("/home") ||
                    uri.contains("/qna") ||
                    uri.contains("/product") ||
                    uri.contains("/ListJobCustomer") ||
                    uri.contains("/AddJobCustomer") ||
                    uri.contains("/blog") ||
                    uri.contains("/post-detail") ||
                    uri.contains("/coupon-subscribe") ||
                    uri.contains("/retail-chain")) {
            chain.doFilter(req, res);
            return;
        }

        // Public
        if (uri.endsWith("/LoginServlet")
                || uri.endsWith("/LogoutServlet")
                || uri.contains("/HomeServlet")
                || uri.contains("/assets/")
                || uri.endsWith("/no-access")
                || uri.contains("/error-page/")
                || uri.contains("/ForgotPassword")
                || uri.contains("/ResetPassword")
                || uri.contains("/verifycode")
        ) {
            chain.doFilter(req, res);
            return;
        }

        // Check login quản lý
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(context + "/LoginServlet");
            return;
        }

        // Check role
        Accounts acc = (Accounts) session.getAttribute("account");
        String roleName = getRoleName(acc.getRole_id());

        if (!isAllowed(uri, roleName)) {
            response.sendRedirect(context + "/no-access");
            return;
        }

        chain.doFilter(req, res);
    }

    private boolean isAllowed(String uri, String role) {
        // Các path chung ai cũng vào được
        List<String> commonPaths = Arrays.asList(
                "/verifycode", "/ResetPassword", "/ForgotPassword", "/HomeAdmin"
        );
        if (commonPaths.stream().anyMatch(uri::contains)) return true;

        // Admin full quyền
        if ("Admin".equals(role)) return true;

        // Staff
        if ("Staff".equals(role)) {
            List<String> staffPaths = Arrays.asList(
                    "/addCustomerPos", "/addToCart", "/barcode-image", "/checkout",
                    "/update-cart", "/createVNPayQR", "/customerLookup", "/loadProduct",
                    "/qrPayment", "/resetOrder", "/scan-barcode", "/searchProduct",
                    "/vnPayReturn","/employee-schedule","/shop-assignment","/warehouse-assignment"
            );
            return staffPaths.stream().anyMatch(uri::contains);
        }

        // Shop Manager
        if ("Shop Manager".equals(role)) {
            List<String> shopManagerPaths = Arrays.asList(
                    "/list-store-stock", "/import-product", "/export-old-batch",
                    "/find-product-store", "/delete-store-stock"
            );
            return shopManagerPaths.stream().anyMatch(uri::contains);
        }

        // Warehouse Manager
        if ("Warehouse Manager".equals(role)) {
            List<String> warehousePaths = Arrays.asList(
                    "/inventory", "/add-inventory-product", "/log-inventory"
            );
            return warehousePaths.stream().anyMatch(uri::contains);
        }

        // Default: Không cho truy cập
        return false;
    }

    private String getRoleName(int roleId) {
        switch (roleId) {
            case 1: return "Admin";
            case 2: return "Staff";
            case 3: return "Shop Manager";
            case 4: return "Warehouse Manager";
            default: return "";
        }
    }
}