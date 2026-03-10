package service;

import entity.Order;
import entity.OrderDetail;
import enumType.OrderStatus;

import java.util.List;

public interface OrderService {
    void createOrder(Order order, List<OrderDetail> details);
    void updateOrderStatus(String orderId, OrderStatus status);
    void deleteOrder(String orderId);
    Order findOrderById(String orderId);

    List<Order> findOrdersByUser(String userId);
    List<Order> findAllOrders();
}
