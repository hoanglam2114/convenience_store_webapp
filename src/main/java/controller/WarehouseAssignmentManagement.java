package controller;

import dao.WarehouseAssignmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import model.WarehouseAssignment;

/**
 * Servlet implementation class WarehouseAssignmentManagement
 */
@WebServlet("/warehouse-assignment")
public class WarehouseAssignmentManagement extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private WarehouseAssignmentDAO warehouseAssignmentDAO;
    
    @Override
    public void init() throws ServletException {
        warehouseAssignmentDAO = new WarehouseAssignmentDAO();
    }
    
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listWarehouseAssignments(request, response);
                break;
            case "detail":
                viewWarehouseDetail(request, response);
                break;
            case "view":
                viewAssignmentDetail(request, response);
                break;
            default:
                listWarehouseAssignments(request, response);
                break;
        }
    }
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    /**
     * List all warehouse assignments grouped by warehouses
     */
    private void listWarehouseAssignments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get all warehouses
            List<WarehouseAssignment> warehouses = warehouseAssignmentDAO.getWarehousesGrouped();
            
            // Create a map to store assignments for each warehouse
            Map<Integer, List<WarehouseAssignment>> warehouseAssignmentsMap = new HashMap<>();
            Map<Integer, Integer> managerCountMap = new HashMap<>();
            Map<Integer, Integer> staffCountMap = new HashMap<>();
            
            // Get assignments for each warehouse and count roles
            for (WarehouseAssignment warehouse : warehouses) {
                List<WarehouseAssignment> assignments = warehouseAssignmentDAO.getAssignmentsByWarehouseId(warehouse.getWarehouseId());
                warehouseAssignmentsMap.put(warehouse.getWarehouseId(), assignments);
                
                int managerCount = 0;
                int staffCount = 0;
                
                for (WarehouseAssignment assignment : assignments) {
                    if (assignment.isActive()) {
                        if ("Manager".equalsIgnoreCase(assignment.getAssignmentRole())) {
                            managerCount++;
                        } else {
                            staffCount++;
                        }
                    }
                }
                
                managerCountMap.put(warehouse.getWarehouseId(), managerCount);
                staffCountMap.put(warehouse.getWarehouseId(), staffCount);
            }
            
            request.setAttribute("warehouses", warehouses);
            request.setAttribute("warehouseAssignmentsMap", warehouseAssignmentsMap);
            request.setAttribute("managerCountMap", managerCountMap);
            request.setAttribute("staffCountMap", staffCountMap);
            
            request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải danh sách phân công kho.");
            request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
        }
    }
    
    /**
     * View warehouse detail with assignments
     */
    private void viewWarehouseDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String warehouseIdParam = request.getParameter("warehouseId");
            if (warehouseIdParam == null || warehouseIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/warehouse-assignment");
                return;
            }
            
            int warehouseId = Integer.parseInt(warehouseIdParam);
            
            // Get warehouse assignments
            List<WarehouseAssignment> assignments = warehouseAssignmentDAO.getAssignmentsByWarehouseId(warehouseId);
            
            if (assignments.isEmpty()) {
                request.setAttribute("error", "Không tìm thấy thông tin kho.");
                request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
                return;
            }
            
            // Get warehouse info from first assignment
            WarehouseAssignment warehouseInfo = assignments.get(0);
            
            request.setAttribute("warehouseInfo", warehouseInfo);
            request.setAttribute("assignments", assignments);
            request.setAttribute("isWarehouseDetail", true);
            
            request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/warehouse-assignment");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin kho.");
            request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
        }
    }
    
    /**
     * View assignment detail
     */
    private void viewAssignmentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String assignmentIdParam = request.getParameter("assignmentId");
            if (assignmentIdParam == null || assignmentIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/warehouse-assignment");
                return;
            }
            
            int assignmentId = Integer.parseInt(assignmentIdParam);
            
            // Get assignment detail
            WarehouseAssignment assignment = warehouseAssignmentDAO.getAssignmentById(assignmentId);
            
            if (assignment == null) {
                request.setAttribute("error", "Không tìm thấy thông tin phân công.");
                request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("assignment", assignment);
            request.setAttribute("isAssignmentDetail", true);
            
            request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/warehouse-assignment");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thông tin phân công.");
            request.getRequestDispatcher("/view/warehouse-assignment.jsp").forward(request, response);
        }
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Warehouse Assignment Management Servlet";
    }
}
