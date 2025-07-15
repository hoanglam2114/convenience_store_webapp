<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.Products" %>

<%
    Order order = (Order) request.getAttribute("order");
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
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
            }
        </style>
    </head>
    <body class="bg-gray-100 flex justify-center py-10">
        <div id="invoice-content"> <!-- Bắt đầu -->
            <div class="bg-white shadow-lg rounded-md p-6 w-full max-w-md font-mono">
                <h1 class="text-center text-xl font-bold border-b pb-2 mb-4">HÓA ĐƠN THANH TOÁN</h1>

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
                        <% for (CartItem item : cartItems) { %>
                        <tr class="border-b">
                            <td class="p-2"><%= item.getProduct().getName() %></td>
                            <td class="p-2 text-right"><%= item.getQuantity() %></td>
                            <td class="p-2 text-right"><%= String.format("%,.0f", item.getPrice()) %></td>
                            <td class="p-2 text-right"><%= String.format("%,.0f", item.getSubTotal()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <div class="text-right text-lg font-bold mt-2">
                    Tổng cộng: <%= String.format("%,.0f", order.getOrderTotalAmount()) %> đ
                </div>

                <div class="text-center mt-6 no-print">
                    <button onclick="exportToPDF()" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded mt-4">
                        <i class="fas fa-file-pdf mr-2"></i> Xuất hóa đơn PDF
                    </button>
                </div>
            </div>
        </div>
    </body>

    <!-- Thư viện HTML2PDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

    <script>
                        function exportToPDF() {
                            const element = document.getElementById('invoice-content'); // phần bạn muốn in
                            const opt = {
                                margin: 0.3,
                                filename: 'hoa_don.pdf',
                                image: {type: 'jpeg', quality: 0.98},
                                html2canvas: {scale: 2},
                                jsPDF: {unit: 'in', format: 'a4', orientation: 'portrait'}
                            };
                            html2pdf().set(opt).from(element).save();
                        }
    </script>
</html>
