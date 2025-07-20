package controller;

/**
 * @author hoang on 7/21/2025-3:28 AM
 * IntelliJ IDEA
 */

import dao.QnADAO;
import model.QnA;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "AdminQnAServlet", urlPatterns = {"/admin/qna"})
public class AdminQnAServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        QnADAO qnaDAO = new QnADAO();
        try {
            List<QnA> qnaList = qnaDAO.getAll();
            request.setAttribute("qnaList", qnaList);
            request.getRequestDispatcher("/view/admin-qna.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error loading Q&A: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        QnADAO qnaDAO = new QnADAO();
        try {
            if ("answer".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String answer = request.getParameter("answer");
                qnaDAO.answerQuestion(id, answer);
            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String answer = request.getParameter("answer");
                qnaDAO.answerQuestion(id, answer); // dùng lại logic update
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                qnaDAO.deleteQuestion(id);
            }
            response.sendRedirect("qna");
        } catch (SQLException e) {
            throw new ServletException("Error processing admin Q&A: " + e.getMessage(), e);
        }
    }
}