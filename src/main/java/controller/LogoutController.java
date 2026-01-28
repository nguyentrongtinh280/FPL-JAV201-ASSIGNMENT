package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session != null) {
            session.invalidate();
        }

        Cookie cUser = new Cookie("username", "");
        cUser.setMaxAge(0);
        cUser.setPath("/");

        resp.addCookie(cUser);

        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
