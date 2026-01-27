package entity;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class OrderDetailId implements Serializable {

    private String orderId;
    private String productDetailId;
}

