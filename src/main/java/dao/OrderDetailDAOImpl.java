package dao;

import entity.OrderDetail;
import entity.OrderDetailId;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

import java.util.List;

public class OrderDetailDAOImpl implements OrderDetailDAO{

    @Override
    public void create(OrderDetail orderDetail) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(orderDetail);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(OrderDetail orderDetail) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(orderDetail);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(OrderDetailId id) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            OrderDetail orderDetail = em.find(OrderDetail.class, id);
            if (orderDetail != null) {
                em.remove(orderDetail);
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
    public OrderDetail findById(OrderDetailId id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(OrderDetail.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public List<OrderDetail> findByOrderId(String orderId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT od FROM OrderDetail od WHERE od.order.orderId = :orderId";
            TypedQuery<OrderDetail> query = em.createQuery(jpql, OrderDetail.class);
            query.setParameter("orderId", orderId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}
