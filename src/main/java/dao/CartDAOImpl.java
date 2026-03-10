package dao;

import entity.Cart;
import entity.CartItem;
import entity.CartItemId;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

public class CartDAOImpl implements CartDAO {

    @Override
    public Cart findCartByUserId(String userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql =
                    "select c from Cart c " +
                            "left join fetch c.cartItems ci " +
                            "left join fetch ci.productDetail pd " +
                            "left join fetch pd.product " +
                            "where c.user.userId = :uid";

            return em.createQuery(jpql, Cart.class)
                    .setParameter("uid", userId)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Cart cart) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(cart);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public void addOrUpdateCartItem(CartItem cartItem) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();

            CartItem existing = em.find(CartItem.class, cartItem.getId());

            if (existing != null) {
                existing.setQuantity(cartItem.getQuantity());

                if (existing.getPrice() == null || existing.getPrice() == 0) {
                    existing.setPrice(
                            cartItem.getProductDetail().getPrice()
                    );
                }
            } else {
                if (cartItem.getPrice() == null || cartItem.getPrice() == 0) {
                    cartItem.setPrice(
                            cartItem.getProductDetail().getPrice()
                    );
                }
                em.persist(cartItem);
            }

            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public void removeCartItem(String cartId, String productDetailId) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            CartItemId id = new CartItemId(cartId, productDetailId);
            CartItem item = em.find(CartItem.class, id);
            if (item != null) {
                em.remove(item);
            }
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw new RuntimeException(e);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean checkCartExist(String userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            Long count = em.createQuery(
                            "select count(c) from Cart c where c.user.userId = :uid",
                            Long.class
                    ).setParameter("uid", userId)
                    .getSingleResult();

            return count > 0;
        } finally {
            em.close();
        }
    }
}