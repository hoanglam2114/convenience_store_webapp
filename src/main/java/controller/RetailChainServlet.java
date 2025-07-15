package controller;

import dao.ShopDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Shop;

import java.io.IOException;
import java.util.List;

/**
 * @author hoang on 7/10/2025-7:02 PM
 * IntelliJ IDEA
 */
@WebServlet(name = "RetailChainServlet", urlPatterns = "/retail-chain")
public class RetailChainServlet extends HttpServlet {
    ShopDAO shopDAO = new ShopDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Shop> shopList = shopDAO.getAll();
        request.setAttribute("shopList", shopList);
        request.getRequestDispatcher("/view/retail-chain.jsp").forward(request, response);
    }
}