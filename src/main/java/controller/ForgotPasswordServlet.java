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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        // ===== 1. GỬI OTP =====
        if ("sendOtp".equals(action)) {

            String username = req.getParameter("username");
            String email = req.getParameter("email");

            User user = userDAO.findByUsername(username);

            if (user != null && user.getEmail().equals(email)) {

                // Tạo OTP 6 số
                String otp = String.valueOf((int)(Math.random() * 900000) + 100000);

                // Lưu vào session
                session.setAttribute("otp", otp);
                session.setAttribute("resetUser", username);

                // Gửi mail
                EmailService.send(
                        email,
                        "OTP Khôi Phục Mật Khẩu",
                        "Mã OTP của bạn là: " + otp + "\nHiệu lực trong 5 phút."
                );

                req.setAttribute("message", "OTP đã được gửi về Email!");
            } else {
                req.setAttribute("error", "Sai Username hoặc Email!");
            }

            req.getRequestDispatcher("/view/OTP.jsp").forward(req, resp);
        }

        // ===== 2. XÁC NHẬN OTP =====
        else if ("verifyOtp".equals(action)) {

            String otpInput = req.getParameter("otp");
            String otpSession = (String) session.getAttribute("otp");

            if (otpSession != null && otpSession.equals(otpInput)) {
                resp.sendRedirect(req.getContextPath() + "/view/ResetPass.jsp");
            } else {
                req.setAttribute("error", "OTP không đúng!");
                req.getRequestDispatcher("/view/OTP.jsp").forward(req, resp);
            }
        }

        // ===== 3. ĐỔI MẬT KHẨU =====
        else if ("resetPass".equals(action)) {

            String newPass = req.getParameter("newPassword");
            String confirm = req.getParameter("confirmPassword");

            if (!newPass.equals(confirm)) {
                req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/view/ResetPass.jsp").forward(req, resp);
                return;
            }

            String username = (String) session.getAttribute("resetUser");

            // Update password trực tiếp (không mã hóa)
            userDAO.updatePassword(username, newPass);

            // Xóa session OTP
            session.removeAttribute("otp");
            session.removeAttribute("resetUser");

            req.setAttribute("message", "Đổi mật khẩu thành công! Mời đăng nhập.");
            req.getRequestDispatcher("/view/Login.jsp").forward(req, resp);
        }
    }
}
