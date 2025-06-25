package controller;

import dao.AccountDAO;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Accounts;
import model.Employees;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "ChangePassword", urlPatterns = {"/ChangePassword"})
public class ChangePassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AccountDAO accDao = new AccountDAO();
        EmployeeDAO empDao = new EmployeeDAO();

        Accounts acc = accDao.getAccountById(id);
        Employees emp = empDao.getEmployeeByAccountId(id);

        request.setAttribute("account", acc);
        request.setAttribute("employee", emp);

        request.getRequestDispatcher("view/Profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int accountId = Integer.parseInt(request.getParameter("accountId"));
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        AccountDAO accDao = new AccountDAO();
        EmployeeDAO empDao = new EmployeeDAO();

        Accounts acc = accDao.getAccountById(accountId);
        Employees emp = empDao.getEmployeeByAccountId(accountId);

        String message;

        if (!newPassword.equals(confirmPassword)) {
            message = "⚠️ Mật khẩu mới và xác nhận không trùng khớp!";
        } else if (!isValidPassword(newPassword)) {
            message = "❗ Mật khẩu phải có ít nhất 8 ký tự, chữ hoa, chữ thường, số và ký tự đặc biệt!";
        } else {
            boolean success = accDao.changePassword(accountId, newPassword);
            message = success ? "✅ Đổi mật khẩu thành công!" : "❌ Lỗi khi cập nhật mật khẩu!";
            acc = accDao.getAccountById(accountId); // Reload lại nếu cần
        }

        request.setAttribute("account", acc);
        request.setAttribute("employee", emp);
        request.setAttribute("message", message);
        request.getRequestDispatcher("view/Profile.jsp").forward(request, response);
    }

    private boolean isValidPassword(String password) {
        return password.length() >= 8
                && password.matches(".*[A-Z].*")
                && password.matches(".*[a-z].*")
                && password.matches(".*[0-9].*")
                && password.matches(".*[!@#$%^&*()].*");
    }

    @Override
    public String getServletInfo() {
        return "Change password servlet using bcrypt";
    }
}
