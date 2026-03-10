package dao;

import entity.ProductDetail;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import utils.XJPA;

import java.util.List;

public class ProductDetailDAOImpl implements ProductDetailDAO {

    @Override
    public void create(ProductDetail pd) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tr = em.getTransaction();
        try {
            tr.begin();
            em.persist(pd);
            tr.commit();
        } catch (Exception e) {
            tr.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void update(ProductDetail pd) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tr = em.getTransaction();
        try {
            tr.begin();
            em.merge(pd);
            tr.commit();
        } catch (Exception e) {
            tr.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String productDetailId) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tr = em.getTransaction();
        try {
            tr.begin();
            ProductDetail pd = em.find(ProductDetail.class, productDetailId);
            if (pd != null) em.remove(pd);
            tr.commit();
        } catch (Exception e) {
            tr.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public ProductDetail findById(String productDetailId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(ProductDetail.class, productDetailId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<ProductDetail> findByProductId(String productId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT pd FROM ProductDetail pd WHERE pd.product.productId = :pid";
            return em.createQuery(jpql, ProductDetail.class)
                    .setParameter("pid", productId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<ProductDetail> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT pd FROM ProductDetail pd";
            return em.createQuery(jpql, ProductDetail.class).getResultList();
        } finally {
            em.close();
        }
    }
}
