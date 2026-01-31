package service;

import dao.OrderDAO;
import dao.OrderDAOImpl;
import dao.OrderDetailDAO;
import dao.OrderDetailDAOImpl;
import entity.Order;
import entity.OrderDetail;
import enumType.OrderStatus;
import enumType.PaymentStatus;

import java.util.List;

public class OrderServiceImpl implements OrderService {

    private final OrderDAO orderDAO = new OrderDAOImpl();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAOImpl();

    @Override
    public void createOrder(Order order, List<OrderDetail> details) {
        if (order.getOrderStatus() == null) {
            order.setOrderStatus(OrderStatus.PENDING);
        }
        if (order.getPaymentStatus() == null) {
            order.setPaymentStatus(PaymentStatus.UNPAID);
        }

        double total = 0;
        for (OrderDetail orderDetail : details) {
            total += orderDetail.getPrice() * orderDetail.getQuantity();
        }
        order.setTotalAmount(total);

        for (OrderDetail orderDetail : details) {
            orderDetail.setOrder(order);
        }

        orderDAO.create(order);
    }

    @Override
    public void updateOrderStatus(String orderId, OrderStatus status) {
        Order order = orderDAO.findById(orderId);
        if (order != null) {
            order.setOrderStatus(status);
            orderDAO.update(order);
        }
    }

    @Override
    public void deleteOrder(String orderId) {
        orderDAO.delete(orderId);
    }

    @Override
    public Order findOrderById(String orderId) {
        return orderDAO.findById(orderId);
    }

    @Override
    public List<Order> findOrdersByUser(String userId) {
        return orderDAO.findByUserId(userId);
    }

    @Override
    public List<Order> findAllOrders() {
        return orderDAO.findAll();
    }
}
