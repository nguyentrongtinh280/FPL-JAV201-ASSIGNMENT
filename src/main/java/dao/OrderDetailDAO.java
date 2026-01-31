package dao;

import entity.OrderDetail;
import entity.OrderDetailId;

import java.util.List;

public interface OrderDetailDAO {

    void create(OrderDetail orderDetail);
    void update(OrderDetail orderDetail);
    void delete(OrderDetailId id);

    OrderDetail findById(OrderDetailId id);
    List<OrderDetail> findByOrderId(String orderId);
}
