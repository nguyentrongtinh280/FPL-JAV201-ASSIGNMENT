package dao;

import entity.Cart;
import entity.CartItem;
import java.util.List;

public interface CartDAO {

    Cart findCartByUserId(String userId);

    void create(Cart cart);

    void addOrUpdateCartItem(CartItem cartItem);

    void removeCartItem(String cartId, String productDetailId);

    boolean checkCartExist(String userId);
}
