package controller;

import dao.CartDAO;
import dao.CartDAOImpl;
import dao.ProductDetailDAO;
import dao.ProductDetailDAOImpl;
import entity.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({
        "/cart",
        "/cart/add",
        "/cart/remove",
        "/cart/update"
})
public class CartController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAOImpl();
    private final ProductDetailDAO productDetailDAO = new ProductDetailDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if (path.equals("/cart")) {
            viewCart(req, resp);
        } else if (path.equals("/cart/add")) {
            addToCart(req, resp);
        } else if (path.equals("/cart/remove")) {
            removeFromCart(req, resp);
        } else if (path.equals("/cart/update")) {
            updateCartQuantity(req, resp);
        }
    }

    private void viewCart(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Cart cart = cartDAO.findCartByUserId(currentUser.getUserId());
        List<CartItemDTO> dtoList = new ArrayList<>();

        if (cart != null && cart.getCartItems() != null) {
            for (CartItem item : cart.getCartItems()) {
                ProductDetail detail = item.getProductDetail();

                dtoList.add(new CartItemDTO(
                        item.getId().getProductDetailId(),
                        detail.getImage(),
                        detail.getProduct().getProductName(),
                        detail.getColor(),
                        detail.getSize(),
                        (item.getPrice() != null && item.getPrice() > 0)
                                ? item.getPrice()
                                : detail.getPrice(),
                        item.getQuantity()
                ));
            }
        }

        double grandTotal = dtoList.stream()
                .mapToDouble(i -> i.getPrice() * i.getQuantity())
                .sum();

        req.setAttribute("cartItems", dtoList);
        req.setAttribute("grandTotal", grandTotal);
        req.getRequestDispatcher("/view/Cart.jsp").forward(req, resp);
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String productDetailId = req.getParameter("productDetailId");

        Cart cart = cartDAO.findCartByUserId(currentUser.getUserId());
        if (cart == null) {
            cart = new Cart();
            cart.setUser(currentUser);
            cartDAO.create(cart);
            cart = cartDAO.findCartByUserId(currentUser.getUserId());
        }

        CartItem existingItem = null;
        for (CartItem item : cart.getCartItems()) {
            if (item.getId().getProductDetailId().equals(productDetailId)) {
                existingItem = item;
                break;
            }
        }

        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + 1);
            cartDAO.addOrUpdateCartItem(existingItem);
        } else {
            ProductDetail realProduct = productDetailDAO.findById(productDetailId);

            if (realProduct != null) {
                CartItem newItem = new CartItem();
                newItem.setId(new CartItemId(cart.getCartId(), productDetailId));
                newItem.setCart(cart);
                newItem.setProductDetail(realProduct);
                newItem.setQuantity(1);

                // 🔥 FIX GIÁ 0 Ở ĐÂY
                newItem.setPrice(realProduct.getPrice());

                cartDAO.addOrUpdateCartItem(newItem);
            }
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void updateCartQuantity(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null) {
            String action = req.getParameter("action");
            String productDetailId = req.getParameter("id");

            Cart cart = cartDAO.findCartByUserId(currentUser.getUserId());

            if (cart != null) {
                for (CartItem item : cart.getCartItems()) {
                    if (item.getId().getProductDetailId().equals(productDetailId)) {

                        if ("decrease".equals(action)) {
                            int newQty = item.getQuantity() - 1;
                            if (newQty > 0) {
                                item.setQuantity(newQty);
                                cartDAO.addOrUpdateCartItem(item);
                            } else {
                                cartDAO.removeCartItem(cart.getCartId(), productDetailId);
                            }
                        }
                        break;
                    }
                }
            }
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void removeFromCart(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser != null) {
            String productDetailId = req.getParameter("id");
            Cart cart = cartDAO.findCartByUserId(currentUser.getUserId());
            if (cart != null) {
                cartDAO.removeCartItem(cart.getCartId(), productDetailId);
            }
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
