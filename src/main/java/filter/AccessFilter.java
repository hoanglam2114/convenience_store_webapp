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
        String context = request.getContextPath();
        String uri = request.getRequestURI();

        // Debug (xem request nào bị chặn)
        // System.out.println("AccessFilter - URI: " + uri);

        // Public paths (bỏ qua login, logout, assets)
        if (uri.equals(context + "/LoginServlet") ||
                uri.equals(context + "/LogoutServlet") ||
                uri.equals(context + "/ForgotPassword") ||
                uri.contains("/view/auth-sign-in.jsp") ||
                uri.contains("/error-page/") ||
                uri.contains("/assets/")) {
            chain.doFilter(req, res);
            return;
        }


        // Check login
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(context + "/LoginServlet");
            return;
        }

        // Lấy thông tin account
        Accounts acc = (Accounts) session.getAttribute("account");
        int roleId = acc.getRole_id();
        String roleName = getRoleName(roleId);

        // Phân quyền theo role
        if (!isAllowed(uri, roleName)) {
            request.getRequestDispatcher("/error-page/no-access.jsp").forward(request, response);
            return;
        }

        // Pass tiếp
        chain.doFilter(req, res);
    }

    private String getRoleName(int roleId) {
        switch (roleId) {
            case 1: return "Admin";
            case 2: return "Staff";
            case 3: return "Warehouse Manager";
            case 4: return "Shop Manager";
            default: return "Unknown";
        }
    }

    // Check quyền truy cập theo URL + role
    private boolean isAllowed(String uri, String role) {
        // Admin -> vào tất cả
        if ("Admin".equals(role)) return true;

        // Staff
        if ("Staff".equals(role)) {
            List<String> staffPages = Arrays.asList("HomeAdmin", "OrderServlet", "CustomerServlet");
            return staffPages.stream().anyMatch(uri::contains);
        }

        // Warehouse Manager
        if ("Warehouse Manager".equals(role)) {
            return uri.contains("Warehouse") || uri.contains("HomeAdmin");
        }

        // Shop Manager
        if ("Shop Manager".equals(role)) {
            return uri.contains("Shop") || uri.contains("HomeAdmin");
        }

        return false;
    }
}