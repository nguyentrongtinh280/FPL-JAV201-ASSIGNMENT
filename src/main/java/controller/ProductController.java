package controller;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import dao.ProductDetailDAO;
import dao.ProductDetailDAOImpl;

import entity.Product;
import entity.ProductDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
@WebServlet({
        "/admin/product",
        "/admin/product/create",
        "/admin/product/delete",
        "/admin/product/update",
        "/admin/product/edit/*",
        "/admin/product/reset",
        "/admin/product/search"
})
public class ProductController extends HttpServlet {

    private ProductDAO productDAO = new ProductDAOImpl();
    private ProductDetailDAO productDetailDAO = new ProductDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        // ===== LOAD DANH SÁCH PRODUCT =====
        req.setAttribute("products", productDAO.findAll());

        // ===== EDIT PRODUCT =====
        if (path.startsWith("/admin/product/edit")) {

            String productId = req.getPathInfo().substring(1);

            // lấy product
            Product product = productDAO.findById(productId);
            req.setAttribute("product", product);
            req.setAttribute("isEdit", true);

            // lấy danh sách chi tiết product
            List<ProductDetail> details =
                    productDetailDAO.findByProductId(productId);
            req.setAttribute("details", details);
        }

        // ===== RESET FORM =====
        if (path.endsWith("/reset")) {
            req.setAttribute("product", new Product());
            req.setAttribute("isEdit", false);
        }

        // ===== SEARCH =====
        if (path.endsWith("/search")) {
            String keyword = req.getParameter("keyword");
            if (keyword != null && !keyword.trim().isEmpty()) {
                req.setAttribute("products",
                        productDAO.findByName(keyword.trim()));
            }
            req.getRequestDispatcher("/view/Product.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/view/Product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Product product = new Product();

        try {
            BeanUtils.populate(product, req.getParameterMap());
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (product.getCreatedAt() == null) {
            product.setCreatedAt(LocalDateTime.now());
        }

        String path = req.getServletPath();

        if (path.endsWith("/create")) {
            productDAO.create(product);

        } else if (path.endsWith("/update")) {
            productDAO.update(product);

        } else if (path.endsWith("/delete")) {
            String id = req.getParameter("id");
            productDAO.delete(id);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }
}
