package controller;

import dao.ProductDetailDAO;
import dao.ProductDetailDAOImpl;
import entity.ProductDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/product-detail")
public class ProductDetailController extends HttpServlet {

    ProductDetailDAO pdDao = new ProductDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String productId = req.getParameter("pid");

        List<ProductDetail> details = pdDao.findByProductId(productId);

        if (details == null || details.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        req.setAttribute("details", details);
        req.setAttribute("detail", details.get(0));

        req.getRequestDispatcher("/view/ProductDetail.jsp").forward(req, resp);
    }
}
