/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Accounts;
import utils.EmailValidator;
import verify.RandomCode;
import verify.SendEmail;

/**
 *
 * @author nguye
 */
public class ForgotPasswordServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ForgotPasswordServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ForgotPasswordServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("view/auth-forgot-password.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("emailRegister");
        String path = "forgotpass";
        
        if (!EmailValidator.isValidEmail(email)) {
            request.setAttribute("error", "Email không hợp lệ!");
            request.getRequestDispatcher("view/auth-forgot-password.jsp").forward(request, response);
            return;
        }
        
        
        if (checkDuplicate(email)) {
            RandomCode rd = new RandomCode();
            String code = rd.activateCode();
            

            String subject = "Yêu cầu đặt lại mật khẩu";
            String content = "<html>  <head>  <meta charset=\"UTF-8\">  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">      "
                    + "<style>          body {              font-family: Arial, sans-serif;              "
                    + "line-height: 1.6;              color: #333;          }          .container {              width: 100%;              max-width: 600px;              margin: 0 auto;              padding: 20px;          }          .button {              display: inline-block;              padding: 10px 20px;              background-color: #4CAF50;              color: #ffffff;              text-decoration: none;              border-radius: 5px;          }      "
                    + "</style>  </head>  <body>      <div class=\"container\">          <h2>Yêu cầu đặt lại mật khẩu</h2>                    "
                    + "<p>Xin chào " + email + ",</p>                    <p>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Để hoàn tất quá trình này, vui lòng sử dụng activate code sau để đổi mật khẩu mới:</p>     " + code + "              " 
                    +  " <p>                        </p>                                 <p>Nếu bạn không thực hiện đăng ký này, vui lòng bỏ qua email này.</p>                    "
                    + "<p>Trân trọng,<br>Đội ngũ hỗ trợ của chúng tôi</p>      </div>  </body>  </html>";
                    

            try {
                HttpSession session = request.getSession();
                session.setAttribute("authcode", code);
                session.setAttribute("authemail", email);
                session.setAttribute("destination", path);
                SendEmail se = new SendEmail();
                se.send(email, subject, content);
//                request.getRequestDispatcher("verifycode").forward(request, response);
                response.sendRedirect("verifycode");

            } catch (Exception e) {
                request.setAttribute("error", "Lỗi hệ thống: Không thể gửi email xác nhận.");
                request.getRequestDispatcher("view/auth-sign-up.jsp").forward(request, response);
            }
        }else {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("view/auth-sign-up.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    
    private boolean checkDuplicate(String email) {
        AccountDAO accDAO = new AccountDAO();
        List<Accounts> listAcc = accDAO.getAllAccount();
        for (Accounts accounts : listAcc) {
            if (accounts.getEmail().equalsIgnoreCase(email)) {
                return true;
            }
        }
        return false;
    }
}
