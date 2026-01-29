package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        boolean isLoginPage = uri.contains("/Login.jsp");
        boolean isLoginServlet = uri.endsWith("/login");
        // Bổ sung thêm gửi mã OTP nếu quên mật khẩu
        boolean isForgotPage = uri.contains("/OTP.jsp") || uri.contains("/forgot-password");
        boolean register = uri.endsWith("/register");
        boolean homeUser = uri.endsWith("/home");

        boolean isResource = uri.contains("/css/")
                || uri.contains("/js/")
                || uri.contains("/images/")
                || uri.contains("/fonts/");

        if (isLoginPage || isLoginServlet || isForgotPage || isResource) {
            if (isLoginPage || isLoginServlet || isResource || homeUser || register) {
                chain.doFilter(request, response);
                return;
            }

            HttpSession session = req.getSession(false);
            Object user = (session != null) ? session.getAttribute("currentUser") : null;

            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                chain.doFilter(request, response);
            }
        }
    }
}
