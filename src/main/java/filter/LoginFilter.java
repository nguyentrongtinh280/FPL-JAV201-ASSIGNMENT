package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
@WebFilter(
        urlPatterns = "/*",
        dispatcherTypes = DispatcherType.REQUEST
)
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();

        if (uri.contains("/images/")
                || uri.contains("/css/")
                || uri.contains("/js/")
                || uri.contains("/fonts/")) {

            chain.doFilter(request, response);
            return;
        }

        boolean isPublic =
                uri.equals(req.getContextPath() + "/")
                || uri.endsWith("/home")
                        || uri.endsWith("/login")
                        || uri.endsWith("/register")
                        || uri.contains("Login.jsp")
                        || uri.contains("Register.jsp")
                        || uri.contains("OTP.jsp");

        if (isPublic) {
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
