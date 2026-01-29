package controller;

import dao.ProductDAO;
import dao.ProductDAOImpl;
import dao.ProductDetailDAO;
import dao.ProductDetailDAOImpl;

import entity.Product;
import entity.ProductDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
@WebServlet({
        "/admin/product",
        "/admin/product/create",
        "/admin/product/delete",
        "/admin/product/update",
        "/admin/product/edit/*",
        "/admin/product/reset",
        "/admin/product/search"
})
public class ProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/view/Productt.jsp").forward(req, resp);
    }
}
