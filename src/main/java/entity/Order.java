package entity;

import enumType.OrderStatus;
import enumType.PaymentStatus;
import jakarta.persistence.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Entity
@Table(name = "Orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "OrderId", length = 36)
    private String orderId;

    @ManyToOne
    @JoinColumn(name = "UserId", nullable = false)
    private User user;

    @CreationTimestamp
    @Column(name = "OrderDate")
    private LocalDateTime orderDate;

    @Column(name = "TotalAmount")
    private Double totalAmount;

    @Column(name = "PaymentMethod", length = 50)
    private String paymentMethod;

    @Enumerated(EnumType.STRING)
    @Column(name = "PaymentStatus", length = 30)
    private PaymentStatus paymentStatus;

    @Enumerated(EnumType.STRING)
    @Column(name = "OrderStatus", length = 30)
    private OrderStatus orderStatus;

    @OneToMany(mappedBy = "order", fetch = FetchType.LAZY,
            cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderDetail> orderDetails;

//    @PrePersist
//    public void prePersist() {
//        orderDate = LocalDateTime.now();
//    }
@Transient
public String getOrderDateFormatted() {
    return orderDate == null ? "" :
            orderDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
}

    public Order() {
    }

    public Order(String orderId, User user, LocalDateTime orderDate, Double totalAmount, String paymentMethod,
                 PaymentStatus paymentStatus, OrderStatus orderStatus, List<OrderDetail> orderDetails) {
        this.orderId = orderId;
        this.user = user;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.orderStatus = orderStatus;
        this.orderDetails = orderDetails;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
}

