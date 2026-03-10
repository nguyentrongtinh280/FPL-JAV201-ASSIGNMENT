package entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class CartItemId implements Serializable {

    @Column(name = "CartId", length = 36, nullable = false)
    private String cartId;

    @Column(name = "ProductDetailId", length = 36, nullable = false)
    private String productDetailId;

    public CartItemId() {
    }

    public CartItemId(String cartId, String productDetailId) {
        this.cartId = cartId;
        this.productDetailId = productDetailId;
    }

    public String getCartId() {
        return cartId;
    }

    public void setCartId(String cartId) {
        this.cartId = cartId;
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
        if (!(o instanceof CartItemId)) return false;
        CartItemId that = (CartItemId) o;
        return Objects.equals(cartId, that.cartId)
                && Objects.equals(productDetailId, that.productDetailId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(cartId, productDetailId);
    }
}
