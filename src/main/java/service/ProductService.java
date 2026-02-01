package service;

import entity.Product;
import entity.ProductDetail;

import java.util.List;

public interface ProductService {

    List<Product> findAll();
    List<Product> search(String keyword);

    Product findById(String productId);

    void create(Product product, ProductDetail productDetail);
    void update(Product product, ProductDetail productDetail);
    void delete(String productId);

    ProductDetail findProductDetailById(String productDetailId);

}
