package filter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * @author hoang on 7/20/2025-4:12 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "noAccess", urlPatterns = {"/no-access"})
public class noAccess extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy attribute "error" từ request, nếu null thì gán chuỗi rỗng
        String errorMessage = (String) req.getSession().getAttribute("error");
        if (errorMessage == null) {
            errorMessage = "";
        }
        req.setAttribute("error", errorMessage);
        req.getSession().removeAttribute("error"); // Xóa attribute khỏi session sau khi sử dụng
        req.getRequestDispatcher("error-page/no-access.jsp").forward(req, resp);
    }
}
