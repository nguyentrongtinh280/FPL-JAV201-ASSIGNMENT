package dao;

import entity.Product;
import java.util.List;

public interface ProductDAO {
    void create(Product product);
    void update(Product product);
    void delete(String productId);
    Product findById(String productId);
    List<Product> findAll();
    List<Product> findByName(String keyword);
}
