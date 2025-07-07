<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Kết quả thanh toán VNPay</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 40px;
            }
            .success {
                color: green;
                font-weight: bold;
            }
            .fail {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <h2>KẾT QUẢ THANH TOÁN QUA VNPay</h2>

        <%
            String responseCode = request.getParameter("vnp_ResponseCode");
            String transactionNo = request.getParameter("vnp_TransactionNo");
            String amount = request.getParameter("vnp_Amount");
            String orderId = request.getParameter("vnp_TxnRef");
            String bankCode = request.getParameter("vnp_BankCode");

            if ("00".equals(responseCode)) {
        %>
        <p class="success">✅ Thanh toán thành công!</p>
        <ul>
            <li>Mã đơn hàng: <strong><%= orderId %></strong></li>
            <li>Số tiền: <strong><%= Long.parseLong(amount)/100 %> VND</strong></li>
            <li>Mã giao dịch: <strong><%= transactionNo %></strong></li>
            <li>Ngân hàng: <strong><%= bankCode %></strong></li>
        </ul>
        <%
            } else {
        %>
        <p class="fail">❌ Thanh toán thất bại. Mã lỗi: <%= responseCode %></p>
        <%
            }
        %>

        <br>
        <a href="view/pos-home.jsp">🔙 Quay lại trang POS</a>
    </body>
</html>
