package dao;

import entity.Category;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

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
}
