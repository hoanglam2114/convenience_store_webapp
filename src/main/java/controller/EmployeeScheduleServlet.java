package controller;

import dao.EmployeeDAO;
import dao.EmployeeShiftScheduleDAO;
import dao.ShiftDAO;
import dao.ShopDAO;
import dao.WarehouseDAO;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

import model.EmployeeShiftSchedule;
import model.Employees;
import model.Shift;
import model.Shop;
import model.Warehouse;

@WebServlet(name = "EmployeeScheduleServlet", urlPatterns = {"/employee-schedule"})
public class EmployeeScheduleServlet extends HttpServlet {

    private final EmployeeShiftScheduleDAO scheduleDAO = new EmployeeShiftScheduleDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final ShiftDAO shiftDAO = new ShiftDAO();
    private final ShopDAO shopDAO = new ShopDAO();
    private final WarehouseDAO warehouseDAO = new WarehouseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        // Kiểm tra session đăng nhập
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            request.getRequestDispatcher("view/auth-sign-in.jsp").forward(request, response);
            return;
        }
        
        // Lấy thông tin account từ session
        Accounts account = (Accounts) session.getAttribute("account");
        int accountId = account.getAccount_id();
        
        // Kiểm tra quyền truy cập - chỉ employee mới được xem lịch của mình
        if (account.getRole_id() == 2){
        } else {
            request.setAttribute("error", "Bạn không có quyền truy cập chức năng này");
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
            return;
        }
        
        
        
        // Lấy thông tin nhân viên từ account_id
        Employees employee = employeeDAO.getEmployeeByAccountId(accountId);
        
        if (employee == null) {
            request.setAttribute("error", "Không tìm thấy thông tin nhân viên");
            request.getRequestDispatcher("view/employee-schedule.jsp").forward(request, response);
            return;
        }
        
        // Lấy tham số ngày từ request, mặc định là ngày hiện tại
        String dateParam = request.getParameter("date");
        LocalDate selectedDate = (dateParam == null || dateParam.isEmpty()) ? 
            LocalDate.now() : LocalDate.parse(dateParam);
        
        // Lấy lịch làm việc của nhân viên trong tuần
        List<EmployeeShiftSchedule> weeklySchedules = getWeeklySchedule(employee.getId(), selectedDate);
        
        // Lấy thông tin các ca làm việc
        List<Shift> shifts = shiftDAO.getAllShifts();
        Map<Integer, Shift> shiftMap = new HashMap<>();
        for (Shift shift : shifts) {
            shiftMap.put(shift.getShiftId(), shift);
        }
        
        // Lấy thông tin shops và warehouses
        List<Shop> shops = shopDAO.getAll();
        List<Warehouse> warehouses = warehouseDAO.getAllWarehouses();
        
        Map<Integer, Shop> shopMap = new HashMap<>();
        for (Shop shop : shops) {
            shopMap.put(shop.getShopId(), shop);
        }
        
        Map<Integer, Warehouse> warehouseMap = new HashMap<>();
        for (Warehouse warehouse : warehouses) {
            warehouseMap.put(warehouse.getWarehouseID(), warehouse);
        }
        
        // Tạo lịch tuần
        Map<LocalDate, EmployeeShiftSchedule> dailyScheduleMap = new HashMap<>();
        for (EmployeeShiftSchedule schedule : weeklySchedules) {
            dailyScheduleMap.put(schedule.getWorkDate().toLocalDate(), schedule);
        }
        
        // Tạo danh sách 7 ngày trong tuần
        LocalDate startOfWeek = selectedDate.minusDays(selectedDate.getDayOfWeek().getValue() - 1);
        List<LocalDate> weekDates = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            weekDates.add(startOfWeek.plusDays(i));
        }
        
        // Format dates for display
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String startDateFormatted = startOfWeek.format(formatter);
        String endDateFormatted = startOfWeek.plusDays(6).format(formatter);
        // NEW_EDIT Build list of formatted strings
        List<String> weekDatesFormatted = new ArrayList<>();
        for (LocalDate date : weekDates) {
            weekDatesFormatted.add(date.format(formatter));
        }
        
        // Set attributes
        request.setAttribute("employee", employee);
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("weekDates", weekDates);
        request.setAttribute("weekDatesFormatted", weekDatesFormatted);
        request.setAttribute("startDateFormatted", startDateFormatted);
        request.setAttribute("endDateFormatted", endDateFormatted);
        request.setAttribute("dailyScheduleMap", dailyScheduleMap);
        request.setAttribute("shiftMap", shiftMap);
        request.setAttribute("shopMap", shopMap);
        request.setAttribute("warehouseMap", warehouseMap);
        
        request.getRequestDispatcher("view/employee-schedule.jsp").forward(request, response);
    }
    
    private List<EmployeeShiftSchedule> getWeeklySchedule(int employeeId, LocalDate selectedDate) {
        List<EmployeeShiftSchedule> allSchedules = new ArrayList<>();
        
        // Lấy ngày đầu và cuối tuần
        LocalDate startOfWeek = selectedDate.minusDays(selectedDate.getDayOfWeek().getValue() - 1);
        LocalDate endOfWeek = startOfWeek.plusDays(6);
        
        // Lấy lịch làm việc trong tuần (cần thêm method này vào DAO)
        // Tạm thời dùng cách đơn giản: lấy từng ngày
        for (LocalDate date = startOfWeek; !date.isAfter(endOfWeek); date = date.plusDays(1)) {
            // Kiểm tra xem nhân viên có làm việc ở shop nào không
            List<EmployeeShiftSchedule> daySchedules = scheduleDAO.getSchedulesByEmployeeAndDate(employeeId, Date.valueOf(date));
            allSchedules.addAll(daySchedules);
        }
        
        return allSchedules;
    }

    @Override
    public String getServletInfo() {
        return "Servlet for employee to view their work schedule.";
    }
} 