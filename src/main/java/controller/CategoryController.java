package controller;

import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.CategoryService;
import service.CategoryServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet({
        "/admin/category",
        "/admin/category/create",
        "/admin/category/update",
        "/admin/category/edit",
        "/admin/category/delete",
        "/admin/category/reset",
        "/admin/category/search"
})
public class CategoryController extends HttpServlet {

    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();
        List<Category> categories;

        if (uri.contains("edit")) {
            String id = req.getParameter("categoryId");
            if (id != null && !id.isBlank()) {
                Category c = categoryService.findById(id);
                req.setAttribute("category", c);
                req.setAttribute("isEdit", true);
            }
        }

        if (uri.contains("search")) {
            String keyword = req.getParameter("keyword");
            if (keyword != null && !keyword.isBlank()) {
                categories = categoryService.search(keyword);
            } else {
                categories = categoryService.findAll();
            }
        } else {
            categories = categoryService.findAll();
        }

        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/view/Category.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();

        if (uri.contains("reset")) {
            resp.sendRedirect(req.getContextPath() + "/admin/category");
            return;
        }

        if (uri.contains("delete")) {
            String id = req.getParameter("categoryId");
            if (id != null && !id.isBlank()) {
                categoryService.delete(id);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/category");
            return;
        }

        Map<String, String> errors = validate(req);

        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("category", buildCategoryFromRequest(req));
            req.setAttribute("categories", categoryService.findAll());

            if (uri.contains("update")) {
                req.setAttribute("isEdit", true);
            }

            req.getRequestDispatcher("/view/Category.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("create")) {
            Category c = buildCategoryFromRequest(req);
            categoryService.create(c);
        } else if (uri.contains("update")) {
            Category c = buildCategoryFromRequest(req);
            categoryService.update(c);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }

    private Category buildCategoryFromRequest(HttpServletRequest req) {
        Category c = new Category();
        c.setCategoryId(req.getParameter("categoryId"));
        c.setCategoryName(req.getParameter("categoryName"));
        c.setDescription(req.getParameter("description"));
        return c;
    }

    private Map<String, String> validate(HttpServletRequest req) {
        Map<String, String> errors = new HashMap<>();

        String name = req.getParameter("categoryName");
        String currentId = req.getParameter("categoryId");

        if (name == null || name.isBlank()) {
            errors.put("categoryName", "Tên danh mục không được để trống");
        } else {
            for (Category c : categoryService.findAll()) {
                if (c.getCategoryName().equalsIgnoreCase(name.trim())) {
                    if (currentId == null || currentId.isBlank()
                            || !currentId.equals(c.getCategoryId())) {
                        errors.put("categoryName", "Tên danh mục đã tồn tại");
                        break;
                    }
                }
            }
        }

        return errors;
    }
}
