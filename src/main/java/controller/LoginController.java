package controller;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/Login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String usernameOrEmail = req.getParameter("username");
        String password = req.getParameter("password");
        String rememberMe = req.getParameter("remember");

        boolean hasError = false;
        if (usernameOrEmail == null || usernameOrEmail.isBlank()) {
            req.setAttribute("emptyUsernameOrEmail", true);
            hasError = true;
        }

        if (password == null || password.isBlank()) {
            req.setAttribute("emptyPassword", true);
            hasError = true;
        }
        if (hasError) {
            req.getRequestDispatcher("/view/Login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.findUserByEmailOrUsername(usernameOrEmail);
        if (user == null) {
            req.setAttribute("errorEmailOrUsername", "Tên đăng nhập hoặc email không tồn tại!");
            req.getRequestDispatcher("/view/Login.jsp").forward(req, resp);
            return;
        }

        if (!user.getPassword().equals(password)) {
            req.setAttribute("errorPassword", "Sai mật khẩu!");
            req.getRequestDispatcher("/view/Login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession();
        session.setAttribute("currentUser", user);

        if (rememberMe != null) {
            Cookie cUser = new Cookie("username", usernameOrEmail);
            cUser.setMaxAge(7 * 24 * 60 * 60);
            cUser.setPath("/");
            resp.addCookie(cUser);
        } else {
            Cookie cUser = new Cookie("username", "");
            cUser.setMaxAge(0);
            cUser.setPath("/");
            resp.addCookie(cUser);
        }

        if (user.isRole()) {
            resp.sendRedirect(req.getContextPath() + "/admin/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
