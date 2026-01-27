package entity;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class CartItemId implements Serializable {

    private String cartId;
    private String productDetailId;
}

