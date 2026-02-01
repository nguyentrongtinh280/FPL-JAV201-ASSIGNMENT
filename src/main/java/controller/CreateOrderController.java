package controller;

import entity.Order;
import entity.OrderDetail;
import entity.ProductDetail;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.OrderService;
import service.OrderServiceImpl;
import service.ProductService;
import service.ProductServiceImpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

//Lưu ý: này chỉ đặt hàng của 1 sản phẩm thôi nha kkk
@WebServlet("/order-create")
public class CreateOrderController extends HttpServlet {

    private final OrderService orderService = new OrderServiceImpl();
    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("currentUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String[] productDetailIds = req.getParameterValues("productDetailIds");
        String[] quantities = req.getParameterValues("quantities");
        String paymentMethod = req.getParameter("paymentMethod");

        Order order = new Order();
        order.setUser(user);
        order.setPaymentMethod(paymentMethod);

        List<OrderDetail> details = new ArrayList<>();

        for (int i = 0; i < productDetailIds.length; i++) {
            ProductDetail productDetail = productService.findProductDetailById(productDetailIds[i]);

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setProductDetail(productDetail);
            orderDetail.setQuantity(Integer.parseInt(quantities[i]));
            orderDetail.setPrice(productDetail.getPrice());

            details.add(orderDetail);
        }

        orderService.createOrder(order, details);

        resp.sendRedirect(req.getContextPath() + "/my-order");

    }
}
