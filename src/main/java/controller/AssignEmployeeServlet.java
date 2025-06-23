package controller;

import dao.EmployeeDAO;
import dao.EmployeeStoreAssignmentDAO;
import dao.ShopDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.EmployeeWithRole;
import model.Employees;
import model.Shop;

public class AssignEmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EmployeeDAO eDAO = new EmployeeDAO();
        ShopDAO sDAO = new ShopDAO();

        List<EmployeeWithRole> employeeList = eDAO.getAllEmployeesWithRoles(); // Đảm bảo có roleName
        List<Shop> shopList = sDAO.getAll();
        
        request.setAttribute("employeeList", employeeList);
        request.setAttribute("shopList", shopList);

        EmployeeStoreAssignmentDAO assignDAO = new EmployeeStoreAssignmentDAO();
        request.setAttribute("assignmentList", assignDAO.getAllAssignmentsWithDetails());

        request.getRequestDispatcher("view/assignEmployeeToShop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int employeeId = Integer.parseInt(request.getParameter("employeeId"));
        int shopId = Integer.parseInt(request.getParameter("shopId"));

        EmployeeDAO eDAO = new EmployeeDAO();
        String role = eDAO.getRoleNameByEmployeeId(employeeId); // "Manager" hoặc "Staff"

        boolean assigned = false;
        EmployeeStoreAssignmentDAO assignDAO = new EmployeeStoreAssignmentDAO();

        if ("Manager".equalsIgnoreCase(role)) {
            // Kiểm tra cửa hàng đã có Manager chưa
            if (assignDAO.shopHasManager(shopId)) {
                request.setAttribute("error", " Cửa hàng đã có Manager.");
            } else if (assignDAO.employeeIsAssigned(employeeId)) {
                request.setAttribute("error", " Manager này đã được phân công vào cửa hàng khác.");
            } else if (assignDAO.assignmentExists(employeeId, shopId)) {
                request.setAttribute("error", " Phân công đã tồn tại.");
            } else {
                assigned = assignDAO.assignEmployeeToShop(employeeId, shopId);
            }
        } else {
            // Kiểm tra nhân viên Staff đã được gán vào cửa hàng này chưa
            if (assignDAO.assignmentExists(employeeId, shopId)) {
                request.setAttribute("error", " Nhân viên đã được phân công vào cửa hàng này.");
            }else if(assignDAO.employeeIsAssigned(employeeId)){
                request.setAttribute("error", " Staff này đã được phân công vào cửa hàng khác.");
            }
            else {
                assigned = assignDAO.assignEmployeeToShop(employeeId, shopId);
            }
        }

        if (assigned) {
            request.setAttribute("message", "Phân công thành công.");
        } else if (request.getAttribute("error") == null) {
            request.setAttribute("error", "Phân công thất bại. Kiểm tra dữ liệu.");
        }

        doGet(request, response); // Load lại dữ liệu
    }

    @Override
    public String getServletInfo() {
        return "Assign employee to shop (no shift)";
    }
}
