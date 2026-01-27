package entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "Category")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "CategoryId", length = 36)
    private String categoryId;

    @Column(name = "CategoryName", nullable = false, length = 100)
    private String categoryName;

    @Column(name = "Description")
    private String description;

    @OneToMany(mappedBy = "category")
    private List<Product> products;

    public Category(String categoryId, String categoryName, String description, List<Product> products) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.products = products;
    }

    public Category(){
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}

