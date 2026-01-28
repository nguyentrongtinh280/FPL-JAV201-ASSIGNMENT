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

import java.io.IOException;

@WebServlet({
        "/admin/user",
        "/admin/user/create",
        "/admin/user/delete",
        "/admin/user/update",
        "/admin/user/edit/*",
        "/admin/user/reset"
})
public class UserControler extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        req.setAttribute("users", userDAO.getAllUsers());
        if (path.contains("/edit")) {
            String id = req.getParameter("id");
            if (id != null) {
                User user = userDAO.findUserById(id);
                req.setAttribute("user", user);
                req.setAttribute("isEdit", true);
            }
        }
        if (path.endsWith("/reset")) {
            req.setAttribute("user", new User());
            req.setAttribute("isEdit", false);
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

        String path = req.getServletPath();
        if (path.endsWith("/create")) {
            boolean hasError = false;
            if (userDAO.existsByUsername(user.getUsername())) {
                req.setAttribute("errorUsername", "Tên đăng nhập đã tồn tại");
                hasError = true;
            }
            if (userDAO.existsByEmail(user.getEmail())) {
                req.setAttribute("errorEmail", "Email đã tồn tại!");
                hasError = true;
            }
            if (user.getPhone() != null && userDAO.existsByPhone(user.getPhone())) {
                req.setAttribute("errorPhone", "Số điện thoại đã tồn tại!");
                hasError = true;
            }
            if (!req.getParameter("password")
                    .equals(req.getParameter("confirmPassword"))) {
                req.setAttribute("errorPassword", "Mật khẩu không khớp!");
                hasError = true;
            }
            if (hasError) {
                req.setAttribute("user", user);
                req.setAttribute("users", userDAO.getAllUsers());
                req.setAttribute("isEdit", false);
                req.getRequestDispatcher("/view/User.jsp").forward(req, resp);
                return;
            }
            userDAO.createUser(user);
        } else if (path.endsWith("/update")) {
            User oldUser = userDAO.findUserById(user.getUserId());
            boolean hasError = false;
            if (!user.getEmail().equals(oldUser.getEmail())
                    && userDAO.existsByEmail(user.getEmail())) {
                req.setAttribute("errorEmail", "Email đã tồn tại!");
                hasError = true;
            }
            if (user.getPhone() != null
                    && !user.getPhone().equals(oldUser.getPhone())
                    && userDAO.existsByPhone(user.getPhone())) {
                req.setAttribute("errorPhone", "Số điện thoại đã tồn tại!");
                hasError = true;
            }
            if (!req.getParameter("password")
                    .equals(req.getParameter("confirmPassword"))) {
                req.setAttribute("errorPassword", "Mật khẩu không khớp!");
                hasError = true;
            }
            if (hasError) {
                req.setAttribute("user", user);
                req.setAttribute("users", userDAO.getAllUsers());
                req.setAttribute("isEdit", true);
                req.getRequestDispatcher("/view/User.jsp").forward(req, resp);
                return;
            }
            userDAO.updateUser(user);
        } else if (path.endsWith("/delete")) {
            userDAO.deleteUser(user.getUserId());
        }
        resp.sendRedirect(req.getContextPath() + "/admin/user");
    }
}
