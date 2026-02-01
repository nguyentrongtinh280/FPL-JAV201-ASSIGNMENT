package service;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import dao.ProductDetailDAO;
import dao.ProductDetailDAOImpl;
import entity.Product;
import entity.ProductDetail;

import java.util.List;

public class ProductServiceImpl implements ProductService{

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final ProductDetailDAO productDetailDAO = new ProductDetailDAOImpl();

    @Override
    public List<Product> findAll() {
        return productDAO.findAll();
    }

    @Override
    public List<Product> search(String keyword) {
        return productDAO.search(keyword);
    }

    @Override
    public Product findById(String productId) {
        return productDAO.findById(productId);
    }

    @Override
    public void create(Product product, ProductDetail productDetail) {
        productDetail.setProduct(product);
        product.setProductDetails(List.of(productDetail));
        productDAO.create(product);
    }

    @Override
    public void update(Product product, ProductDetail productDetail) {
        productDAO.update(product);
        productDetailDAO.update(productDetail);
    }

    @Override
    public void delete(String productId) {
        productDAO.delete(productId);
    }

    @Override
    public ProductDetail findProductDetailById(String productDetailId) {
        return productDetailDAO.findById((productDetailId));
    }
}
