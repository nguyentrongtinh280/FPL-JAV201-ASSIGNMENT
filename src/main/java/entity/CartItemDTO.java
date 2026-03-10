package entity;

public class CartItemDTO {

    private String productDetailId;
    private String image;
    private String productName;
    private String color;
    private String size;
    private Double price;
    private Integer quantity;

    public CartItemDTO() {
    }

    public CartItemDTO(String productDetailId, String image, String productName,
                       String color, String size, Double price, Integer quantity) {
        this.productDetailId = productDetailId;
        this.image = image;
        this.productName = productName;
        this.color = color;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
    }

    public String getProductDetailId() {
        return productDetailId;
    }

    public String getImage() {
        return image;
    }

    public String getProductName() {
        return productName;
    }

    public String getColor() {
        return color;
    }

    public String getSize() {
        return size;
    }

    public Double getPrice() {
        return price;
    }

    public Integer getQuantity() {
        return quantity;
    }
}