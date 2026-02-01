package entity;

public class OrderItem {
    private ProductDetail productDetail;
    private int quantity;
    private double price;
    private double total;

    public OrderItem(ProductDetail productDetail, int quantity) {
        this.productDetail = productDetail;
        this.quantity = quantity;
        this.price = productDetail.getPrice();
        this.total = this.price * quantity;
    }

    public ProductDetail getProductDetail() {
        return productDetail;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPrice() {
        return price;
    }

    public double getTotal() {
        return total;
    }
}

