package controller;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import utils.EmailService;

import java.io.IOException;
@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/view/OTP.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        if ("sendOtp".equals(action)) {
            String username = req.getParameter("username");
            String email = req.getParameter("email");

            User user = userDAO.findByUsername(username);

            if (user != null && user.getEmail().equals(email)) {

                String otp = String.valueOf((int)(Math.random() * 900000) + 100000);

                session.setAttribute("otp", otp);
                session.setAttribute("resetUser", username);

                EmailService.sendOTP(email, otp);

                req.setAttribute("message", "OTP đã được gửi về Email!");
            } else {
                req.setAttribute("error", "Sai Username hoặc Email!");
            }

            req.getRequestDispatcher("/view/OTP.jsp").forward(req, resp);
        }

        else if ("verifyOtp".equals(action)) {
            String otpInput = req.getParameter("otp");
            String otpSession = (String) session.getAttribute("otp");

            if (otpSession != null && otpSession.equals(otpInput)) {
                resp.sendRedirect(req.getContextPath() + "/reset-password");
            } else {
                req.setAttribute("error", "OTP không đúng!");
                req.getRequestDispatcher("/view/OTP.jsp").forward(req, resp);
            }
        }
    }
}




