package dao;

import entity.Order;

import java.util.List;

public interface OrderDAO {

    void create(Order order);
    void update(Order order);
    void delete(String orderId);

    Order findById(String orderId);

    List<Order> findAll();
    List<Order> findByUserId(String userId);
    List<Order> findByOrderStatus(String orderStatus);
}
