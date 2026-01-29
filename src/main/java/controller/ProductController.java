package controller;

import dao.CategoryDAO;
import dao.CategoryDAOImpl;
import dao.ProductDAO;
import dao.ProductDAOImpl;
import entity.Category;
import entity.Product;
import entity.ProductDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet({
        "/admin/product",
        "/admin/product/create",
        "/admin/product/delete",
        "/admin/product/update",
        "/admin/product/edit/*",
        "/admin/product/reset",
        "/admin/product/search"
})
@MultipartConfig
public class ProductController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        loadCommonData(req);

        if (uri.contains("/edit")) {
            String id = req.getParameter("id");
            Product p = productDAO.findById(id);
            req.setAttribute("product", p);
            req.setAttribute("detail", p.getProductDetails().get(0));
            req.setAttribute("isEdit", true);
        }

        if (uri.contains("/search")) {
            String keyword = req.getParameter("keyword");
            req.setAttribute("products", productDAO.search(keyword));
        }

        req.getRequestDispatcher("/view/Productt.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Map<String, String> errors = new HashMap<>();

        String productName = req.getParameter("productName");
        String categoryId = req.getParameter("categoryId");
        String size = req.getParameter("size");
        String color = req.getParameter("color");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");

        // VALIDATE
        if (productName == null || productName.isBlank())
            errors.put("errorProductName", "Tên sản phẩm không được để trống");

        if (categoryId == null || categoryId.isBlank())
            errors.put("errorCategory", "Vui lòng chọn danh mục");

        if (size == null || size.isBlank())
            errors.put("errorSize", "Vui lòng chọn size");

        if (color == null || color.isBlank())
            errors.put("errorColor", "Vui lòng chọn màu");

        double price = 0;
        if (priceStr == null || priceStr.isBlank()) {
            errors.put("errorPrice", "Giá không được để trống");
        } else {
            price = Double.parseDouble(priceStr);
            if (price <= 0)
                errors.put("errorPrice", "Giá phải > 0");
        }

        int quantity = 0;
        if (quantityStr == null || quantityStr.isBlank()) {
            errors.put("errorQuantity", "Số lượng không được để trống");
        } else {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 0)
                errors.put("errorQuantity", "Số lượng >= 0");
        }

        // Nếu có lỗi → quay lại form
        if (!errors.isEmpty()) {
            errors.forEach(req::setAttribute);
            loadCommonData(req);
            req.getRequestDispatcher("/view/Productt.jsp").forward(req, resp);
            return;
        }

        // UPLOAD IMAGE
        Part imagePart = req.getPart("image");
        String imageName = null;

        if (imagePart != null && imagePart.getSize() > 0) {
            imageName = UUID.randomUUID() + "_" + imagePart.getSubmittedFileName();
            String path = req.getServletContext().getRealPath("/images");
            Files.createDirectories(new File(path).toPath());
            imagePart.write(path + File.separator + imageName);
        }

        Category category = new Category();
        category.setCategoryId(categoryId);

        Product product = new Product();
        product.setProductName(productName);
        product.setCategory(category);
        product.setDescription(req.getParameter("description"));
        product.setCreatedAt(LocalDateTime.now());

        ProductDetail detail = new ProductDetail();
        detail.setProduct(product);
        detail.setSize(size);
        detail.setColor(color);
        detail.setPrice(price);
        detail.setQuantity(quantity);
        detail.setImage(imageName);
        detail.setStatus(req.getParameter("status"));

        product.setProductDetails(List.of(detail));

        if (req.getRequestURI().contains("/create")) {
            productDAO.create(product);
        }

        if (req.getRequestURI().contains("/update")) {
            product.setProductId(req.getParameter("productId"));
            productDAO.update(product);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void loadCommonData(HttpServletRequest req) {
        req.setAttribute("categories", categoryDAO.findAll());
        req.setAttribute("products", productDAO.findAll());
    }
}
