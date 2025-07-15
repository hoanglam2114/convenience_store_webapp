package controller;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;

/**
 * Servlet implementation class AssignmentController
 */
@WebServlet("/assignment-management")
public class AssignmentController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private EmployeeDAO employeeDAO;
    private ShopDAO shopDAO;
    private WarehouseDAO warehouseDAO;
    private ShopAssignmentDAO shopAssignmentDAO;
    private WarehouseAssignmentDAO warehouseAssignmentDAO;
    private ShiftDAO shiftDAO;
    @Override
    public void init() throws ServletException {
        employeeDAO = new EmployeeDAO();
        shopDAO = new ShopDAO();
        warehouseDAO = new WarehouseDAO();
        shopAssignmentDAO = new ShopAssignmentDAO();
        warehouseAssignmentDAO = new WarehouseAssignmentDAO();
        shiftDAO = new ShiftDAO();
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listAssignments(request, response);
                break;
            case "view":
                viewAssignment(request, response);
                break;
            case "edit":
                editAssignment(request, response);
                break;
            case "delete":
                deleteAssignment(request, response);
                break;
            default:
                listAssignments(request, response);
                break;
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "add";
        }

        switch (action) {
            case "add":
                addAssignment(request, response);
                break;
            case "update":
                updateAssignment(request, response);
                break;
            default:
                addAssignment(request, response);
                break;
        }
    }

    /**
     * List all assignments
     */
    private void listAssignments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get all employees for dropdown
            List<Employees> employees = employeeDAO.getAllEmployee();

            // Get all shops for dropdown
            List<Shop> shops = shopDAO.getAll();

            // Get all warehouses for dropdown
            List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
            
            // Get all warehouses for dropdown
            List<Shift> shifts = shiftDAO.getAllShifts();
            
            // Get all assignments
            List<ShopAssignment> shopAssignments = shopAssignmentDAO.getAllShopAssignments();
            List<WarehouseAssignment> warehouseAssignments = warehouseAssignmentDAO.getAllWarehouseAssignments();
            
            // Combine assignments for display
            List<Object> allAssignments = new ArrayList<>();
            allAssignments.addAll(shopAssignments);
            allAssignments.addAll(warehouseAssignments);

            request.setAttribute("employees", employees);
            request.setAttribute("shops", shops);
            request.setAttribute("warehouses", warehouses);
            request.setAttribute("shifts", shifts);
            request.setAttribute("allAssignments", allAssignments);
            request.setAttribute("shopAssignments", shopAssignments);
            request.setAttribute("warehouseAssignments", warehouseAssignments);

            request.getRequestDispatcher("view/assignment-management.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách phân công: " + e.getMessage());
            request.getRequestDispatcher("view/assignment-management.jsp").forward(request, response);
        }
    }

    /**
     * Add new assignment
     */
    private void addAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String employeeIdStr = request.getParameter("employeeId");
            String locationType = request.getParameter("locationType");
            String locationIdStr = request.getParameter("locationId");
            String role = request.getParameter("assignmentRole");
            String startDateStr = request.getParameter("startDate");

            // Debug logging
            System.out.println("=== ADD ASSIGNMENT DEBUG ===");
            System.out.println("employeeIdStr: " + employeeIdStr);
            System.out.println("locationType: " + locationType);
            System.out.println("locationIdStr: " + locationIdStr);
            System.out.println("role: " + role);
            System.out.println("startDateStr: " + startDateStr);

            // Validate input
            if (employeeIdStr == null || locationType == null || locationIdStr == null
                    || role == null) {
                String errorMsg = "Vui lòng điền đầy đủ thông tin! Missing: ";
                if (employeeIdStr == null) {
                    errorMsg += "employeeId ";
                }
                if (locationType == null) {
                    errorMsg += "locationType ";
                }
                if (locationIdStr == null) {
                    errorMsg += "locationId ";
                }
                if (role == null) {
                    errorMsg += "assignmentRole ";
                }

                request.setAttribute("error", errorMsg);
                listAssignments(request, response);
                return;
            }

            int employeeId = Integer.parseInt(employeeIdStr);
            int locationId = Integer.parseInt(locationIdStr);

            // Parse start date - use current date if not provided
            Timestamp startDate;
            if (startDateStr != null && !startDateStr.trim().isEmpty()) {
                startDate = Timestamp.valueOf(startDateStr + " 00:00:00");
            } else {
                startDate = Timestamp.valueOf(LocalDateTime.now().toLocalDate().atStartOfDay());
            }
            Timestamp currentTime = Timestamp.valueOf(LocalDateTime.now());

            if ("shop".equals(locationType)) {
                // Check if assignment already exists
                ShopAssignment existingAssignment = shopAssignmentDAO.getAssignmentByEmployeeAndShop(employeeId, locationId);
                System.out.println("=== SHOP ASSIGNMENT CHECK ===");
                System.out.println("existingAssignment: " + (existingAssignment != null ? "Found" : "Not found"));

                if (existingAssignment != null) {
                    System.out.println("Assignment ID: " + existingAssignment.getAssignmentId());
                    request.setAttribute("error", "Nhân viên đã được phân công tại shop này rồi!");
                    listAssignments(request, response);
                    return;
                }

                if ("Manager".equalsIgnoreCase(role)) {
                    boolean alreadyManager = shopAssignmentDAO.hasShopManager(employeeId);
                    if (alreadyManager) {
                        request.setAttribute("error", "Nhân viên này đã là Quản lý tại một cửa hàng khác. Mỗi Quản lý chỉ được gán vào 1 cửa hàng!");
                        listAssignments(request, response);
                        return;
                    }
                }

                // Add shop assignment
                ShopAssignment assignment = new ShopAssignment();
                assignment.setEmployeeId(employeeId);
                assignment.setShopId(locationId);
                assignment.setAssignmentRole(role);
                assignment.setStartDate(startDate);
                assignment.setActive(true);
                assignment.setCreatedAt(currentTime);
                assignment.setUpdatedAt(currentTime);

                shopAssignmentDAO.addAssignment(assignment);
                request.setAttribute("success", "Thêm phân công shop thành công!");

            } else if ("warehouse".equals(locationType)) {
                // Check if assignment already exists
                WarehouseAssignment existingAssignment = warehouseAssignmentDAO.getAssignmentByEmployeeAndWarehouse(employeeId, locationId);
                System.out.println("=== WAREHOUSE ASSIGNMENT CHECK ===");
                System.out.println("existingAssignment: " + (existingAssignment != null ? "Found" : "Not found"));

                if (existingAssignment != null) {
                    System.out.println("Assignment ID: " + existingAssignment.getAssignmentId());
                    request.setAttribute("error", "Nhân viên đã được phân công tại warehouse này rồi!");
                    listAssignments(request, response);
                    return;
                }

                if ("Manager".equalsIgnoreCase(role)) {
                    boolean alreadyManager = warehouseAssignmentDAO.hasWarehouseManager(employeeId);
                    if (alreadyManager) {
                        request.setAttribute("error", "Nhân viên này đã là Quản lý tại một kho khác. Mỗi Quản lý chỉ được gán vào 1 kho!");
                        listAssignments(request, response);
                        return;
                    }
                }

                // Add warehouse assignment
                WarehouseAssignment assignment = new WarehouseAssignment();
                assignment.setEmployeeId(employeeId);
                assignment.setWarehouseId(locationId);
                assignment.setAssignmentRole(role);
                assignment.setStartDate(startDate);
                assignment.setActive(true);
                assignment.setCreatedAt(currentTime);
                assignment.setUpdatedAt(currentTime);

                warehouseAssignmentDAO.addAssignment(assignment);
                request.setAttribute("success", "Thêm phân công warehouse thành công!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi thêm phân công: " + e.getMessage());
        }

        listAssignments(request, response);
    }

    /**
     * View assignment details
     */
    private void viewAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String assignmentIdStr = request.getParameter("assignmentId");
            String type = request.getParameter("type");
            String isAjax = request.getParameter("ajax");

            if (assignmentIdStr == null || type == null) {
                if ("true".equals(isAjax)) {
                    response.getWriter().write("<div class='alert alert-danger'>Thông tin không hợp lệ!</div>");
                    return;
                }
                request.setAttribute("error", "Thông tin không hợp lệ!");
                listAssignments(request, response);
                return;
            }

            int assignmentId = Integer.parseInt(assignmentIdStr);

            if ("shop".equals(type)) {
                ShopAssignment assignment = shopAssignmentDAO.getAssignmentById(assignmentId);
                request.setAttribute("assignment", assignment);
                request.setAttribute("type", "shop");
                request.getRequestDispatcher("view/assignment-detail.jsp").forward(request, response);
                return;
            } else if ("warehouse".equals(type)) {
                WarehouseAssignment assignment = warehouseAssignmentDAO.getAssignmentById(assignmentId);
                request.setAttribute("assignment", assignment);
                request.setAttribute("type", "warehouse");
                request.getRequestDispatcher("view/assignment-detail.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(request.getParameter("ajax"))) {
                response.getWriter().write("<div class='alert alert-danger'>Có lỗi xảy ra khi tải thông tin phân công: " + e.getMessage() + "</div>");
                return;
            }
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin phân công: " + e.getMessage());
        }

        listAssignments(request, response);
    }

    /**
     * Edit assignment
     */
    private void editAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String assignmentIdStr = request.getParameter("assignmentId");
            String type = request.getParameter("type");
            String isAjax = request.getParameter("ajax");

            if (assignmentIdStr == null || type == null) {
                if ("true".equals(isAjax)) {
                    response.getWriter().write("<div class='alert alert-danger'>Thông tin không hợp lệ!</div>");
                    return;
                }
                request.setAttribute("error", "Thông tin không hợp lệ!");
                listAssignments(request, response);
                return;
            }

            int assignmentId = Integer.parseInt(assignmentIdStr);

            if ("shop".equals(type)) {
                ShopAssignment assignment = shopAssignmentDAO.getAssignmentById(assignmentId);
                request.setAttribute("assignment", assignment);
                request.setAttribute("type", "shop");
                request.getRequestDispatcher("view/assignment-edit.jsp").forward(request, response);
                return;
            } else if ("warehouse".equals(type)) {
                WarehouseAssignment assignment = warehouseAssignmentDAO.getAssignmentById(assignmentId);
                request.setAttribute("assignment", assignment);
                request.setAttribute("type", "warehouse");
                request.getRequestDispatcher("view/assignment-edit.jsp").forward(request, response);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            if ("true".equals(request.getParameter("ajax"))) {
                response.getWriter().write("<div class='alert alert-danger'>Có lỗi xảy ra khi tải thông tin phân công: " + e.getMessage() + "</div>");
                return;
            }
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin phân công: " + e.getMessage());
        }

        listAssignments(request, response);
    }

    /**
     * Update assignment
     */
    private void updateAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String assignmentIdStr = request.getParameter("assignmentId");
            String type = request.getParameter("type");
            String role = request.getParameter("role");
            String endDateStr = request.getParameter("endDate");
            String isActiveStr = request.getParameter("isActive");

            if (assignmentIdStr == null || type == null) {
                request.setAttribute("error", "Thông tin không hợp lệ!");
                listAssignments(request, response);
                return;
            }

            int assignmentId = Integer.parseInt(assignmentIdStr);
            boolean isActive = "true".equals(isActiveStr);
            Timestamp endDate = null;
            if (endDateStr != null && !endDateStr.trim().isEmpty()) {
                endDate = Timestamp.valueOf(endDateStr + " 23:59:59");
            }

            if ("shop".equals(type)) {

                ShopAssignment assignment = shopAssignmentDAO.getAssignmentById(assignmentId);
                if (assignment != null) {
                    Timestamp startDate = assignment.getStartDate();
                    if (endDate != null && startDate != null && endDate.before(startDate)) {
                        request.setAttribute("error", "Ngày kết thúc không được nhỏ hơn ngày bắt đầu!");
                        listAssignments(request, response);
                        return;
                    }
//                    System.out.println("StartDate: " + startDate);
//                    System.out.println("EndDate: " + endDate);
                    assignment.setAssignmentRole(role);
                    assignment.setEndDate(endDate);
                    assignment.setActive(isActive);
                    assignment.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));

                    int shopId = assignment.getShopId();
                    int employeeId = assignment.getEmployeeId();

                    // ⚠️ Kiểm tra nghiệp vụ trước khi cập nhật
                    if ("Manager".equalsIgnoreCase(role)) {
                        if (shopAssignmentDAO.shopHasOtherManager(shopId, assignmentId)) {
                            request.setAttribute("error", "Cửa hàng đã có quản lý khác!");
                            listAssignments(request, response);
                            return;
                        }

                        if (shopAssignmentDAO.employeeIsManagerElsewhere(employeeId, shopId)) {
                            request.setAttribute("error", "Nhân viên này đã là quản lý ở cửa hàng khác!");
                            listAssignments(request, response);
                            return;
                        }
                    }

                    shopAssignmentDAO.updateAssignment(assignment);
                    request.setAttribute("success", "Cập nhật phân công shop thành công!");
                }
            } else if ("warehouse".equals(type)) {
                WarehouseAssignment assignment = warehouseAssignmentDAO.getAssignmentById(assignmentId);
                if (assignment != null) {
                    assignment.setAssignmentRole(role);
                    assignment.setEndDate(endDate);
                    assignment.setActive(isActive);
                    assignment.setUpdatedAt(Timestamp.valueOf(LocalDateTime.now()));

                    int warehouseId = assignment.getWarehouseId();
                    int employeeId = assignment.getEmployeeId();

                    if ("Manager".equalsIgnoreCase(role)) {
                        if (warehouseAssignmentDAO.warehouseHasOtherManager(warehouseId, assignmentId)) {
                            request.setAttribute("error", "Kho này đã có quản lý khác!");
                            listAssignments(request, response);
                            return;
                        }
                        if (warehouseAssignmentDAO.employeeIsManagerElsewhere(employeeId, warehouseId)) {
                            request.setAttribute("error", "Nhân viên này đã là quản lý ở kho khác!");
                            listAssignments(request, response);
                            return;
                        }
                    }

                    warehouseAssignmentDAO.updateAssignment(assignment);
                    request.setAttribute("success", "Cập nhật phân công warehouse thành công!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật phân công: " + e.getMessage());
        }

        listAssignments(request, response);
    }

    /**
     * Delete assignment
     */
    private void deleteAssignment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String assignmentIdStr = request.getParameter("assignmentId");
            String type = request.getParameter("type");

            if (assignmentIdStr == null || type == null) {
                request.setAttribute("error", "Thông tin không hợp lệ!");
                listAssignments(request, response);
                return;
            }

            int assignmentId = Integer.parseInt(assignmentIdStr);

            if ("shop".equals(type)) {
                shopAssignmentDAO.deleteAssignment(assignmentId);
                request.setAttribute("success", "Xóa phân công shop thành công!");
            } else if ("warehouse".equals(type)) {
                warehouseAssignmentDAO.deleteAssignment(assignmentId);
                request.setAttribute("success", "Xóa phân công warehouse thành công!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi xóa phân công: " + e.getMessage());
        }

        listAssignments(request, response);
    }
}
