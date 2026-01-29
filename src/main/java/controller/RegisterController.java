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

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/Register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String confirmPassword = req.getParameter("confirmPassword");
        User user = new User();
        try {
            BeanUtils.populate(user, req.getParameterMap());
            user.setRole(false);
        } catch (Exception e) {
            e.printStackTrace();
        }

        boolean hasError = false;

        if (user.getFullname() == null || user.getFullname().isBlank()) {
            req.setAttribute("emptyFullname", true);
            hasError = true;
        }

        if (user.getUsername() == null || user.getUsername().isBlank()) {
            req.setAttribute("emptyUsername", true);
            hasError = true;
        }

        if (user.getPhone() == null || user.getPhone().isBlank()) {
            req.setAttribute("emptyPhone", true);
            hasError = true;
        }

        if (user.getPassword() == null || user.getPassword().isBlank()) {
            req.setAttribute("emptyPassword", true);
            hasError = true;
        }

        if (confirmPassword == null || confirmPassword.isBlank()) {
            req.setAttribute("emptyConfirmPassword", true);
            hasError = true;
        }

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
        if (!hasError && !user.getPassword().equals(confirmPassword)) {
            req.setAttribute("errorPassword", "Mật khẩu không khớp!");
            hasError = true;
        }
        if (hasError) {
            req.setAttribute("user", user);
            req.getRequestDispatcher("/view/Register.jsp").forward(req, resp);
            return;
        }

        userDAO.createUser(user);

        resp.sendRedirect(req.getContextPath() + "/home");

    }
}
