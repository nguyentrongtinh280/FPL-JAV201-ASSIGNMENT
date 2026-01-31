package dao;

import entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

import java.util.List;

public class OrderDAOImpl implements OrderDAO{

    @Override
    public void create(Order order) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(order);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Order order) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(order);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }  finally {
            em.close();
        }
    }

    @Override
    public void delete(String orderId) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            Order order = em.find(Order.class, orderId);
            if (order != null) {
                em.remove(order);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Order findById(String orderId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Order.class, orderId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o ORDER BY o.orderDate DESC";
            TypedQuery<Order> query = em.createQuery(jpql, Order.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order> findByUserId(String userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = """
            SELECT DISTINCT o FROM Order o
            LEFT JOIN FETCH o.orderDetails od
            LEFT JOIN FETCH od.productDetail pd
            LEFT JOIN FETCH pd.product
            WHERE o.user.userId = :uid
            ORDER BY o.orderDate DESC
        """;
            return em.createQuery(jpql, Order.class)
                    .setParameter("uid", userId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Order> findByOrderStatus(String orderStatus) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT o FROM Order o WHERE o.orderStatus = :status";
            TypedQuery<Order> query = em.createQuery(jpql, Order.class);
            query.setParameter("status", orderStatus);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
