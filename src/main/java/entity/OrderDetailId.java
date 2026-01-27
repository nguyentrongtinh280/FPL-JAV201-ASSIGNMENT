package entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class OrderDetailId implements Serializable {

    @Column(name = "OrderId", length = 36, nullable = false)
    private String orderId;

    @Column(name = "ProductDetailId", length = 36, nullable = false)
    private String productDetailId;

    public OrderDetailId() {
    }

    public OrderDetailId(String orderId, String productDetailId) {
        this.orderId = orderId;
        this.productDetailId = productDetailId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(String productDetailId) {
        this.productDetailId = productDetailId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof OrderDetailId)) return false;
        OrderDetailId that = (OrderDetailId) o;
        return Objects.equals(orderId, that.orderId)
                && Objects.equals(productDetailId, that.productDetailId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderId, productDetailId);
    }
}
