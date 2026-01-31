package controller;

import dao.UserDAO;
import dao.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("resetUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.getRequestDispatcher("/view/ResetPass.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String username = (String) session.getAttribute("resetUser");

        if (username == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (!newPass.equals(confirm)) {
            req.setAttribute("error", "Mật khẩu không khớp");
            req.getRequestDispatcher("/view/ResetPass.jsp").forward(req, resp);
            return;
        }

        userDAO.updatePassword(username, newPass);

        // clear session
        session.removeAttribute("otp");
        session.removeAttribute("resetUser");

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
