package controller;

import dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/home")
public class HomeAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        DashboardDAO dao = new DashboardDAO();

        req.setAttribute("users", dao.totalUsers());
        req.setAttribute("categories", dao.totalCategories());
        req.setAttribute("products", dao.totalProducts());
        req.setAttribute("productDetails", dao.totalProductDetails());
        req.setAttribute("orders", dao.totalOrders());
        req.setAttribute("revenue", dao.totalRevenue());

        req.getRequestDispatcher("/view/IndexAdmin.jsp").forward(req, resp);
    }
}
