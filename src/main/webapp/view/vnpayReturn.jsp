<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Kết quả thanh toán VNPay</title>
    </head>
    <body>
        <h1>Kết quả thanh toán</h1>
        <p><strong>Mã giao dịch:</strong> ${txnRef}</p>
        <p><strong>Số tiền:</strong> ${amount}</p>
        <p><strong>Trạng thái:</strong>
            <span style="color: ${success ? 'green' : 'red'}; font-weight: bold;">
                ${success ? "Thành công" : "Thất bại"}
            </span>
        </p>
        <a href="loadProducts">⬅ Quay lại POS</a>
    </body>
</html>
