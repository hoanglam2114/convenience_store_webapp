package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * @author hoang on 6/22/2025-8:19 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "SendOTPServlet",urlPatterns = "/send-otp")
public class SendOTPServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String phone = request.getParameter("phone");

        // Tạo OTP ngẫu nhiên
        String otp = String.valueOf((int)(Math.random() * 900000) + 100000);

        // Lưu vào session
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("phone", phone);

        // Demo
        System.out.println("OTP gửi tới " + phone + ": " + otp);

        response.sendRedirect("verify-otp");
    }
}
