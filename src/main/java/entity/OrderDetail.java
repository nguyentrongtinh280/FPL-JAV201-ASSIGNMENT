package entity;

import jakarta.persistence.*;

@Entity
@Table(name = "OrderDetail")
public class OrderDetail {

    @EmbeddedId
    private OrderDetailId id;

    @ManyToOne
    @MapsId("orderId")
    @JoinColumn(name = "OrderId", nullable = false)
    private Order order;

    @ManyToOne
    @MapsId("productDetailId")
    @JoinColumn(name = "ProductDetailId", nullable = false)
    private ProductDetail productDetail;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    @Column(name = "Price", nullable = false)
    private Double price;

    @Column(name = "Total", nullable = false)
    private Double total;

    public OrderDetail() {
    }

    public OrderDetail(OrderDetailId id, Order order, ProductDetail productDetail,
                       Integer quantity, Double price, Double total) {
        this.id = id;
        this.order = order;
        this.productDetail = productDetail;
        this.quantity = quantity;
        this.price = price;
        this.total = total;
    }

    public ProductDetail getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(ProductDetail productDetail) {
        this.productDetail = productDetail;
    }

    public OrderDetailId getId() {
        return id;
    }

    public void setId(OrderDetailId id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }
}
