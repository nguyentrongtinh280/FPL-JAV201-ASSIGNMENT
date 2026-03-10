package controller;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import service.UserService;
import service.UserServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet({
        "/admin/user",
        "/admin/user/create",
        "/admin/user/delete",
        "/admin/user/update",
        "/admin/user/edit/*",
        "/admin/user/reset",
        "/admin/user/search"
})
public class UserControler extends HttpServlet {

    //private UserDAO userDAO = new UserDAOImpl();

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        req.setAttribute("users", userService.findAll());
        if (path.contains("/edit")) {
            String id = req.getParameter("id");
            if (id != null) {
                req.setAttribute("user", userService.findById(id));
                req.setAttribute("isEdit", true);
            }
        }
        if (path.endsWith("/reset")) {
            req.setAttribute("user", new User());
            req.setAttribute("isEdit", false);
        }
        if (path.endsWith("/search")) {
            String keyword = req.getParameter("keyword");
            if (keyword != null && !keyword.trim().isEmpty()) {
                req.setAttribute("users", userService.search(keyword.trim()));
            } else {
                req.setAttribute("users", userService.findAll());
            }

            req.getRequestDispatcher("/view/User.jsp").forward(req, resp);
            return;
        }
        req.getRequestDispatcher("/view/User.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        try {
            BeanUtils.populate(user, req.getParameterMap());
            boolean role = Boolean.parseBoolean(req.getParameter("role"));
            user.setRole(role);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String confirmPassword = req.getParameter("confirmPassword");
        Map<String, String> errors = new HashMap<>();
        String path = req.getServletPath();

        if (path.endsWith("/create")) {
            errors = userService.create(user, confirmPassword);

        } else if (path.endsWith("/update")) {
            errors = userService.update(user, confirmPassword);

        } else if (path.endsWith("/delete")) {
            userService.delete(user.getUserId());
            resp.sendRedirect(req.getContextPath() + "/admin/user");
            return;
        }

        if (!errors.isEmpty()) {
            errors.forEach(req::setAttribute);
            req.setAttribute("user", user);
            req.setAttribute("users", userService.findAll());
            req.setAttribute("isEdit", path.endsWith("/update"));
            req.getRequestDispatcher("/view/User.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/admin/user");
    }
}
