package dao;

import entity.ProductDetail;
import java.util.List;

public interface ProductDetailDAO {

    void create(ProductDetail pd);

    void update(ProductDetail pd);

    void delete(String productDetailId);

    ProductDetail findById(String productDetailId);

    List<ProductDetail> findByProductId(String productId);

    List<ProductDetail> findAll();
}
