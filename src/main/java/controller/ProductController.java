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
import service.CategoryService;
import service.CategoryServiceImpl;
import service.ProductService;
import service.ProductServiceImpl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet({
        "/admin/product",
        "/admin/product/create",
        "/admin/product/update",
        "/admin/product/delete",
        "/admin/product/edit/*",
        "/admin/product/reset",
        "/admin/product/search"
})
@MultipartConfig
public class ProductController extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final CategoryService categoryService = new CategoryServiceImpl();
    private static final String IMAGE_FOLDER = "images";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        loadCommonData(req);
        List<Product> products = productService.findAll();

        if (uri.contains("/search")) {
            String keyword = req.getParameter("keyword");
            if (keyword != null && !keyword.isBlank()) {
                products = productService.search(keyword);
            }
        }

        if (uri.contains("/edit")) {
            String id = req.getParameter("id");
            Product product = productService.findById(id);
            req.setAttribute("product", product);
            req.setAttribute("detail", product.getProductDetails().get(0));
            req.setAttribute("isEdit", true);
        }

        req.setAttribute("products", products);
        req.getRequestDispatcher("/view/Productt.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        Map<String, String> errors = validate(req);
        if (!errors.isEmpty()) {
            errors.forEach(req::setAttribute);
            Product product = buildProductFromRequest(req);
            ProductDetail productDetail = buildDetailFromRequest(req);

            req.setAttribute("product", product);
            req.setAttribute("detail", productDetail);

            loadCommonData(req);
            req.getRequestDispatcher("/view/Productt.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("/create")) {
            create(req, resp);
        } else if (uri.contains("/update")) {
            update(req, resp);
        } else if (uri.contains("/delete")) {
            delete(req, resp);
        } else if (uri.contains("/reset")) {
            resp.sendRedirect(req.getContextPath() + "/admin/product");
        }

    }

    private void create(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        Category category = new Category();
        category.setCategoryId(req.getParameter("categoryId"));

        Product product = new Product();
        product.setProductName(req.getParameter("productName"));
        product.setCategory(category);
        product.setDescription(req.getParameter("description"));

        ProductDetail detail = new ProductDetail();
        fillDetail(req, detail);

        productService.create(product, detail);
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        Product product = productService.findById(req.getParameter("productId"));
        product.setProductName(req.getParameter("productName"));
        product.setDescription(req.getParameter("description"));

        ProductDetail detail = product.getProductDetails().get(0);
        fillDetail(req, detail);

        productService.update(product, detail);
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private void delete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        productService.delete(req.getParameter("productId"));
        resp.sendRedirect(req.getContextPath() + "/admin/product");
    }

    private Map<String, String> validate(HttpServletRequest req) {
        Map<String, String> errors = new HashMap<>();

        if (req.getParameter("productName").isBlank()) {
            errors.put("errorProductName", "Vui lòng nhập tên sản phẩm");
        }

        if (req.getParameter("categoryId").isBlank()) {
            errors.put("errorCategory", "Vui lòng chọn danh mục");
        }

        if (req.getParameter("size").isBlank()) {
            errors.put("errorSize", "Vui lòng chọn size");
        }

        if (req.getParameter("color").isBlank()) {
            errors.put("errorColor", "Vui lòng chọn màu");
        }

        try {
            double price = Double.parseDouble(req.getParameter("price"));
            if (price <= 0) {
                errors.put("errorPrice", "Giá phải lớn hơn 0");
            }
        } catch (NumberFormatException e) {
            errors.put("errorPrice", "Giá không hợp lệ");
        }

        try {
            double quantity = Double.parseDouble(req.getParameter("quantity"));
            if (quantity < 0) {
                errors.put("errorQuantity", "Số lượng phải lớn hơn 0");
            }
        } catch (NumberFormatException e) {
            errors.put("errorQuantity", "Số lượng không hợp lệ");
        }

        return errors;
    }

    private Product buildProductFromRequest(HttpServletRequest req) {
        Product p = new Product();
        p.setProductId(req.getParameter("productId"));
        p.setProductName(req.getParameter("productName"));
        p.setDescription(req.getParameter("description"));

        Category c = new Category();
        c.setCategoryId(req.getParameter("categoryId"));
        p.setCategory(c);

        return p;
    }

    private ProductDetail buildDetailFromRequest(HttpServletRequest req) {
        ProductDetail d = new ProductDetail();
        d.setSize(req.getParameter("size"));
        d.setColor(req.getParameter("color"));
        d.setStatus(req.getParameter("status"));

        try {
            d.setPrice(Double.parseDouble(req.getParameter("price")));
        } catch (Exception e) {}

        try {
            d.setQuantity(Integer.parseInt(req.getParameter("quantity")));
        } catch (Exception e) {}

        return d;
    }


    private void fillDetail(HttpServletRequest req, ProductDetail d)
            throws IOException, ServletException {

        d.setSize(req.getParameter("size"));
        d.setColor(req.getParameter("color"));
        d.setPrice(Double.valueOf(req.getParameter("price")));
        d.setQuantity(Integer.valueOf(req.getParameter("quantity")));
        d.setStatus(req.getParameter("status"));

        Part file = req.getPart("image");
        if (file != null && file.getSize() > 0) {

            String fileName = UUID.randomUUID() + "_" +
                    Paths.get(file.getSubmittedFileName()).getFileName().toString();

            String realPath = req.getServletContext().getRealPath("/" + IMAGE_FOLDER);

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            file.write(realPath + File.separator + fileName);
            d.setImage(fileName);
        }
    }



    private void loadCommonData(HttpServletRequest req) {
        req.setAttribute("categories", categoryService.findAll());
    }

}
