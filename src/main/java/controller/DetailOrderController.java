package controller;

import dao.ProductDetailDAO;
import dao.ProductDetailDAOImpl;
import entity.OrderItem;
import entity.ProductDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

//Lưu ý: này chỉ hiển thị chi tiết đơn hàng của 1 sản phẩm thôi nha kkk
@WebServlet("/order-detail")
public class DetailOrderController extends HttpServlet {
    private final ProductDetailDAO productDetailDAO = new ProductDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pdid = req.getParameter("pdid");
        if (pdid == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        ProductDetail pd = productDetailDAO.findById(pdid);
        if (pd == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        OrderItem item = new OrderItem(pd, 1);
        double shippingFee = 50000;

        req.setAttribute("orderItems", List.of(item));
        req.setAttribute("subtotal", item.getTotal());
        req.setAttribute("shippingFee", shippingFee);
        req.setAttribute("totalAmount", item.getTotal() + shippingFee);

        req.getRequestDispatcher("/view/Order.jsp").forward(req, resp);
    }
}
