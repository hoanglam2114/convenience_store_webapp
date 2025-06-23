package controller;

import dao.ShopAssignmentDAO;
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
import model.ShopAssignment;

/**
 * Servlet implementation class ShopAssignmentManagement
 */
@WebServlet("/shop-assignment")
public class ShopAssignmentManagement extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ShopAssignmentDAO shopAssignmentDAO;
    
    @Override
    public void init() throws ServletException {
        shopAssignmentDAO = new ShopAssignmentDAO();
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
                listShopAssignments(request, response);
                break;
            case "detail":
                viewShopDetail(request, response);
                break;
            case "view":
                viewAssignmentDetail(request, response);
                break;
            default:
                listShopAssignments(request, response);
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
     * List all shop assignments grouped by shops
     */
    private void listShopAssignments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get all shops
            List<ShopAssignment> shops = shopAssignmentDAO.getShopsGrouped();
            
            // Create a map to store assignments for each shop
            Map<Integer, List<ShopAssignment>> shopAssignmentsMap = new HashMap<>();
            Map<Integer, Integer> managerCountMap = new HashMap<>();
            Map<Integer, Integer> staffCountMap = new HashMap<>();
            
            // Get assignments for each shop and count roles
            for (ShopAssignment shop : shops) {
                List<ShopAssignment> assignments = shopAssignmentDAO.getAssignmentsByShopId(shop.getShopId());
                shopAssignmentsMap.put(shop.getShopId(), assignments);
                
                int managerCount = 0;
                int staffCount = 0;
                
                for (ShopAssignment assignment : assignments) {
                    if (assignment.isActive()) {
                        if ("Quản lý".equals(assignment.getAssignmentRole()) || 
                            "Manager".equals(assignment.getAssignmentRole())) {
                            managerCount++;
                        } else if ("Nhân viên".equals(assignment.getAssignmentRole()) || 
                                  "Staff".equals(assignment.getAssignmentRole())) {
                            staffCount++;
                        }
                    }
                }
                
                managerCountMap.put(shop.getShopId(), managerCount);
                staffCountMap.put(shop.getShopId(), staffCount);
            }
            
            request.setAttribute("shops", shops);
            request.setAttribute("shopAssignmentsMap", shopAssignmentsMap);
            request.setAttribute("managerCountMap", managerCountMap);
            request.setAttribute("staffCountMap", staffCountMap);
            
            request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
        }
    }
    
    /**
     * View detail of a specific shop with all its assignments
     */
    private void viewShopDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String shopIdParam = request.getParameter("shopId");
            if (shopIdParam == null || shopIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/shop-assignment");
                return;
            }
            
            int shopId = Integer.parseInt(shopIdParam);
            
            // Get shop assignments
            List<ShopAssignment> assignments = shopAssignmentDAO.getAssignmentsByShopId(shopId);
            
            if (assignments.isEmpty()) {
                request.setAttribute("error", "Không tìm thấy thông tin shop.");
                request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
                return;
            }
            
            // Get shop info from first assignment
            ShopAssignment shopInfo = assignments.get(0);
            
            request.setAttribute("shopInfo", shopInfo);
            request.setAttribute("assignments", assignments);
            request.setAttribute("isDetailView", true);
            
            request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/shop-assignment");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải chi tiết shop: " + e.getMessage());
            request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
        }
    }
    
    /**
     * View detail of a specific assignment
     */
    private void viewAssignmentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String assignmentIdParam = request.getParameter("assignmentId");
            if (assignmentIdParam == null || assignmentIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/shop-assignment");
                return;
            }
            
            int assignmentId = Integer.parseInt(assignmentIdParam);
            
            // Get assignment detail
            ShopAssignment assignment = shopAssignmentDAO.getAssignmentById(assignmentId);
            
            if (assignment == null) {
                request.setAttribute("error", "Không tìm thấy thông tin phân công.");
                request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("assignment", assignment);
            request.setAttribute("isAssignmentDetail", true);
            
            request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/shop-assignment");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải chi tiết phân công: " + e.getMessage());
            request.getRequestDispatcher("/view/shop-assignment.jsp").forward(request, response);
        }
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Shop Assignment Management Servlet";
    }
}
