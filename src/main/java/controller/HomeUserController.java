package controller;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/home")
public class HomeUserController extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        if (keyword != null && !keyword.trim().isEmpty()) {
            req.setAttribute("products", productDAO.search(keyword));
            req.setAttribute("keyword", keyword);
        } else {
            req.setAttribute("products", productDAO.findAll());
        }
        req.getRequestDispatcher("/Home.jsp").forward(req, resp);
    }
}

