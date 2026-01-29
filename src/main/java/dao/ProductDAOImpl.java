package dao;

import entity.Product;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

import java.util.List;

public class ProductDAOImpl implements ProductDAO {
    @Override
    public void create(Product product) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(product);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(product);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(String productId) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Product product = em.find(Product.class, productId);
            if (product != null) {
                em.remove(product);
            }
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Product findById(String productId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(Product.class, productId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            TypedQuery<Product> query =
                    em.createQuery("SELECT p FROM Product p ORDER BY p.createdAt DESC", Product.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> search(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            keyword = keyword.trim();

            // 1. Nếu là khoảng giá (vd: 100000-300000)
            if (keyword.matches("\\d+\\s*-\\s*\\d+")) {
                String[] parts = keyword.split("-");
                Double min = Double.parseDouble(parts[0].trim());
                Double max = Double.parseDouble(parts[1].trim());

                TypedQuery<Product> query = em.createQuery(
                        """
                        SELECT DISTINCT p
                        FROM Product p
                        JOIN p.productDetails d
                        WHERE d.price BETWEEN :min AND :max
                        """,
                        Product.class
                );
                query.setParameter("min", min);
                query.setParameter("max", max);
                return query.getResultList();
            }

            if (keyword.matches("\\d+")) {
                Double price = Double.parseDouble(keyword);

                TypedQuery<Product> query = em.createQuery(
                        """
                        SELECT DISTINCT p
                        FROM Product p
                        JOIN p.productDetails d
                        WHERE d.price = :price
                        """,
                        Product.class
                );
                query.setParameter("price", price);
                return query.getResultList();
            }

            TypedQuery<Product> query = em.createQuery(
                    """
                    SELECT DISTINCT p
                    FROM Product p
                    JOIN p.category c
                    WHERE LOWER(p.productName) LIKE LOWER(:kw)
                       OR LOWER(c.categoryName) LIKE LOWER(:kw)
                    """,
                    Product.class
            );
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();

        } finally {
            em.close();
        }
    }
}
