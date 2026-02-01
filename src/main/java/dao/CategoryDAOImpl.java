package dao;

import entity.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category> search(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT c FROM Category c WHERE c.categoryName LIKE :keyword";
            TypedQuery<Category> query = em.createQuery(jpql, Category.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public Category findById(String id) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Category.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public void create(Category category) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String id) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category category = em.find(Category.class, id);
            if (category != null) {
                em.remove(category);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
