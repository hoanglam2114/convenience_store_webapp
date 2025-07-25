<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.Products" %>
<%@ page import="model.Coupons" %>

<%
    Order order = (Order) request.getAttribute("order");
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");

    double discount = 0;
    double rawTotal = 0;

    if (order != null) {
        discount = order.getDiscountAmount();
        rawTotal = order.getOrderTotalAmount() + discount;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hóa đơn</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @media print {
                .no-print {
                    display: none;
                }
                body {
                    background: white !important;
                    padding: 0;
                    margin: 0;
                }
                table, th, td {
                    border: 1px solid #ccc;
                    border-collapse: collapse;
                }
                th, td {
                    padding: 6px;
                }
            }
        </style>
    </head>
    <body class="bg-gray-100 flex justify-center py-10">
        <div id="invoice-content">
            <div class="bg-white shadow-lg rounded-md p-6 w-full max-w-md font-mono">
                <h1 class="text-center text-xl font-bold border-b pb-2 mb-4">HÓA ĐƠN THANH TOÁN</h1>

                <% if (order != null) { %>
                <div class="text-sm mb-4 space-y-1">
                    <p><strong>Mã hóa đơn:</strong> <%= order.getOrderId() %></p>
                    <p><strong>Khách hàng:</strong> <%= order.getCustomerName() %></p>
                    <p><strong>Ngày:</strong> <%= order.getOrderDate() %></p>
                    <p><strong>Nhân viên:</strong> <%= order.getEmployeeName() %></p>
                </div>

                <table class="w-full text-sm mb-4">
                    <thead class="bg-gray-200">
                        <tr>
                            <th class="p-2 text-left">Sản phẩm</th>
                            <th class="p-2 text-right">SL</th>
                            <th class="p-2 text-right">Đơn giá</th>
                            <th class="p-2 text-right">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (cartItems != null) {
                            for (CartItem item : cartItems) { %>
                        <tr class="border-b">
                            <td class="p-2"><%= item.getProduct().getName() %></td>
                            <td class="p-2 text-right"><%= item.getQuantity() %></td>
                            <td class="p-2 text-right"><%= String.format("%,.0f", item.getPrice()) %></td>
                            <td class="p-2 text-right"><%= String.format("%,.0f", item.getSubTotal()) %></td>
                        </tr>
                        <%  } } %>
                    </tbody>
                </table>

                <div class="text-right text-sm space-y-1 mb-2">
                    <p><strong>Tạm tính:</strong> <%= String.format("%,.0f", rawTotal) %> đ</p>
                    <% if (discount > 0) { %>
                    <p class="text-green-600"><strong>Giảm giá (<%= order.getCouponCode() %>):</strong> -<%= String.format("%,.0f", discount) %> đ</p>
                    <% } %>
                    <p class="font-bold text-lg text-black">Tổng cộng: <%= String.format("%,.0f", order.getOrderTotalAmount()) %> đ</p>
                </div>
                <% } else { %>
                <p class="text-red-600 font-bold text-center">⚠️ Không tìm thấy thông tin đơn hàng.</p>
                <% } %>

                <div class="text-center mt-2 no-print">
                    <button onclick="window.print()" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                        <i class="fas fa-print mr-2"></i> In hóa đơn
                    </button>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    </body>

    <script>
                        function printInvoice() {
                            const content = document.getElementById('invoice-content').innerHTML;
                            const printWindow = window.open('', '', 'width=800,height=600');
                            printWindow.document.write('<html><head><title>Hóa đơn</title>');
                            printWindow.document.write('<style>body{font-family:sans-serif;padding:20px;} table{width:100%;border-collapse:collapse;} td, th{border:1px solid #ccc;padding:8px;text-align:left;} .text-center{text-align:center}</style>');
                            printWindow.document.write('</head><body>');
                            printWindow.document.write(content);
                            printWindow.document.write('</body></html>');
                            printWindow.document.close();
                            printWindow.focus();
                            setTimeout(() => {
                                printWindow.print();
                                printWindow.close();
                            }, 500);
                        }
    </script>
</html>
