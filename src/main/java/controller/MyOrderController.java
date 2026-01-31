package controller;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.OrderService;
import service.OrderServiceImpl;

import java.io.IOException;

@WebServlet("/my-order")
public class MyOrderController extends HttpServlet {

    private final OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("currentUser");

        req.setAttribute("orders", orderService.findOrdersByUser(user.getUserId()));
        req.getRequestDispatcher("/view/MyOrder.jsp").forward(req, resp);
    }
}
