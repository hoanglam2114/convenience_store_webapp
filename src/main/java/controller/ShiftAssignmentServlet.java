package controller;

import dao.EmployeeDAO;
import dao.EmployeeShiftScheduleDAO;
import dao.ShiftDAO;
import dao.ShopAssignmentDAO;
import dao.ShopDAO;
import dao.WarehouseAssignmentDAO;
import dao.WarehouseDAO;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.EmployeeShiftSchedule;
import model.Employees;
import model.Shift;
import model.Shop;
import model.ShopAssignment;
import model.Warehouse;
import model.WarehouseAssignment;

@WebServlet(name = "ShiftAssignmentServlet", urlPatterns = {"/shift-assignment"})
public class ShiftAssignmentServlet extends HttpServlet {

    private final EmployeeShiftScheduleDAO scheduleDAO = new EmployeeShiftScheduleDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final ShiftDAO shiftDAO = new ShiftDAO();
    private final ShopDAO shopDAO = new ShopDAO();
    private final WarehouseDAO warehouseDAO = new WarehouseDAO();
    private final ShopAssignmentDAO shopAssignmentDAO = new ShopAssignmentDAO();
    private final WarehouseAssignmentDAO warehouseAssignmentDAO = new WarehouseAssignmentDAO();

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
            // Add other cases like "delete" if needed
            default:
                listAssignments(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("shift-assignment?action=list");
            return;
        }

        switch (action) {
            case "add":
                addAssignment(request, response);
                break;
            case "delete":
                deleteAssignment(request, response);
                break;
            default:
                response.sendRedirect("shift-assignment?action=list");
                break;
        }
    }

    private void listAssignments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Location and date selection
        String locationType = request.getParameter("locationType"); // "shop" or "warehouse"
        String locationIdStr = request.getParameter("locationId");
        String workDateStr = request.getParameter("workDate");

        LocalDate workDate = (workDateStr == null || workDateStr.isEmpty()) ? LocalDate.now() : LocalDate.parse(workDateStr);
        
        List<Shop> shops = shopDAO.getAll();
        List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
        List<Shift> shifts = shiftDAO.getAllShifts();
        
        request.setAttribute("shops", shops);
        request.setAttribute("warehouses", warehouses);
        request.setAttribute("shifts", shifts);
        request.setAttribute("selectedDate", workDate);

        if (locationType != null && locationIdStr != null && !locationIdStr.isEmpty()) {
            int locationId = Integer.parseInt(locationIdStr);
            List<EmployeeShiftSchedule> schedules;
            List<Employees> employees = new ArrayList<>();

            if ("shop".equals(locationType)) {
                schedules = scheduleDAO.getSchedulesByShopAndDate(locationId, Date.valueOf(workDate));
                List<ShopAssignment> shopAssignments = shopAssignmentDAO.getAssignmentsByShopId(locationId);
                for (ShopAssignment sa : shopAssignments) {
                    Employees emp = employeeDAO.getEmployeeById(sa.getEmployeeId());
                    if (emp != null) {
                        employees.add(emp);
                    }
                }
                request.setAttribute("selectedShopId", locationId);
            } else { // warehouse
                schedules = scheduleDAO.getSchedulesByWarehouseAndDate(locationId, Date.valueOf(workDate));
                List<WarehouseAssignment> warehouseAssignments = warehouseAssignmentDAO.getAssignmentsByWarehouseId(locationId);
                for (WarehouseAssignment wa : warehouseAssignments) {
                    Employees emp = employeeDAO.getEmployeeById(wa.getEmployeeId());
                    if (emp != null) {
                        employees.add(emp);
                    }
                }
                request.setAttribute("selectedWarehouseId", locationId);
            }

            Map<Integer, EmployeeShiftSchedule> scheduleMap = new HashMap<>();
            for(EmployeeShiftSchedule s : schedules) {
                scheduleMap.put(s.getEmployeeId(), s);
            }
            
            request.setAttribute("schedules", schedules);
            request.setAttribute("scheduleMap", scheduleMap);
            request.setAttribute("employees", employees);
            request.setAttribute("selectedLocationType", locationType);
        }

        request.getRequestDispatcher("view/shift-assignment-list.jsp").forward(request, response);
    }

    private void addAssignment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int employeeId = Integer.parseInt(request.getParameter("employeeId"));
            int shiftId = Integer.parseInt(request.getParameter("shiftId"));
            Date workDate = Date.valueOf(request.getParameter("workDate"));
            String locationType = request.getParameter("locationType");
            int locationId = Integer.parseInt(request.getParameter("locationId"));

            EmployeeShiftSchedule schedule = new EmployeeShiftSchedule();
            schedule.setEmployeeId(employeeId);
            schedule.setShiftId(shiftId);
            schedule.setWorkDate(workDate);

            if ("shop".equals(locationType)) {
                schedule.setShopId(locationId);
            } else { // warehouse
                schedule.setWarehouseId(locationId);
            }
            
            // Optional: Add validation to check if the employee is actually assigned to that location on that date.
            
            scheduleDAO.addEmployeeShiftSchedule(schedule);

        } catch (NumberFormatException e) {
            // Handle error - maybe set a message
            e.printStackTrace();
        }
        
        // Redirect back to the list with the same filters
        String locationType = request.getParameter("locationType");
        String locationId = request.getParameter("locationId");
        String workDate = request.getParameter("workDate");
        response.sendRedirect("shift-assignment?action=list&locationType=" + locationType + "&locationId=" + locationId + "&workDate=" + workDate);
    }
    
    private void deleteAssignment(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
        try {
            int scheduleId = Integer.parseInt(request.getParameter("scheduleId"));
            scheduleDAO.deleteEmployeeShiftSchedule(scheduleId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        
        // Redirect back to the list with the same filters
        String locationType = request.getParameter("locationType");
        String locationId = request.getParameter("locationId");
        String workDate = request.getParameter("workDate");
        response.sendRedirect("shift-assignment?action=list&locationType=" + locationType + "&locationId=" + locationId + "&workDate=" + workDate);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing employee shift assignments.";
    }
} 