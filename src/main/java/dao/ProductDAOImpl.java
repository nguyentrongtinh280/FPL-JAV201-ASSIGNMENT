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
            TypedQuery<Product> query = em.createQuery(
                    """
                    SELECT p
                    FROM Product p
                    LEFT JOIN FETCH p.productDetails
                    LEFT JOIN FETCH p.category
                    WHERE p.productId = :id
                    """,
                    Product.class
            );
            query.setParameter("id", productId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = """
                SELECT DISTINCT p
                FROM Product p
                LEFT JOIN FETCH p.productDetails
                LEFT JOIN FETCH p.category
            """;
            return em.createQuery(jpql, Product.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Product> search(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            keyword = keyword.trim();
            if (keyword.matches("\\d+\\s*-\\s*\\d+")) {
                String[] parts = keyword.split("-");
                double min = Double.parseDouble(parts[0].trim());
                double max = Double.parseDouble(parts[1].trim());

                return em.createQuery("""
                SELECT DISTINCT p
                FROM Product p
                JOIN FETCH p.productDetails d
                JOIN FETCH p.category
                WHERE d.price BETWEEN :min AND :max
            """, Product.class)
                        .setParameter("min", min)
                        .setParameter("max", max)
                        .getResultList();
            }

            if (keyword.matches("\\d+")) {
                double price = Double.parseDouble(keyword);

                return em.createQuery("""
                SELECT DISTINCT p
                FROM Product p
                JOIN FETCH p.productDetails d
                JOIN FETCH p.category
                WHERE d.price = :price
            """, Product.class)
                        .setParameter("price", price)
                        .getResultList();
            }

            return em.createQuery("""
            SELECT DISTINCT p
            FROM Product p
            JOIN FETCH p.category c
            JOIN FETCH p.productDetails d
            WHERE LOWER(p.productName) LIKE LOWER(:kw)
               OR LOWER(c.categoryName) LIKE LOWER(:kw)
        """, Product.class)
                    .setParameter("kw", "%" + keyword + "%")
                    .getResultList();

        } finally {
            em.close();
        }
    }
}
