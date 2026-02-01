package controller;

import enumType.OrderStatus;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.OrderService;
import service.OrderServiceImpl;

import java.io.IOException;

@WebServlet({
  "/order/cancel"
})
public class OrderController extends HttpServlet {

    private final OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String orderId = req.getParameter("id");
        orderService.updateOrderStatus(orderId, OrderStatus.CANCEL);

        resp.sendRedirect(req.getContextPath() + "/my-order");
    }
}
