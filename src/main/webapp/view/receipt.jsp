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

                <div class="text-center mt-2 no-print">
                    <button onclick="window.print()" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
                        <i class="fas fa-print mr-2"></i> In hóa đơn
                    </button>
                </div>
            </div>
        </div>
    </body>

    <!-- Thư viện HTML2PDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

    <script>
                        function printInvoice() {
                            const content = document.getElementById('invoice-content').innerHTML;

                            const printWindow = window.open('', '', 'width=800,height=600');
                            printWindow.document.write('<html><head><title>Hóa đơn</title>');
                            printWindow.document.write('<style>body{font-family:sans-serif;padding:20px;} table{width:100%;border-collapse:collapse;} td, th{border:1px solid #ccc;padding:8px;text-align:left;} .text-center{text-align:center}</style>');
                            printWindow.document.write('</head><body >');
                            printWindow.document.write(content);
                            printWindow.document.write('</body></html>');

                            printWindow.document.close();
                            printWindow.focus();

                            setTimeout(() => {
                                printWindow.print();
                                printWindow.close();
                            }, 500); // chờ load nội dung
                        }
    </script>
</html>
