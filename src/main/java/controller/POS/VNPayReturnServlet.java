package controller.POS;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class VNPayReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String responseCode = request.getParameter("vnp_ResponseCode");
        String orderIdStr = request.getParameter("vnp_TxnRef");
        String amountStr = request.getParameter("vnp_Amount");

        System.out.println("VNPay callback received:");
        System.out.println("TxnRef: " + orderIdStr);
        System.out.println("Amount: " + amountStr);
        System.out.println("ResponseCode: " + responseCode);

        request.setAttribute("txnRef", orderIdStr);
        request.setAttribute("amount", amountStr);
        request.setAttribute("success", "00".equals(responseCode));

        request.getRequestDispatcher("view/vnpayReturn.jsp").forward(request, response);
    }
}
