package dao;

import jakarta.persistence.EntityManager;
import utils.XJPA;

public class DashboardDAO {

    private Long count(String jpql) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(jpql, Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public Long totalUsers() {
        return count("SELECT COUNT(u) FROM User u");
    }

    public Long totalCategories() {
        return count("SELECT COUNT(c) FROM Category c");
    }

    public Long totalProducts() {
        return count("SELECT COUNT(p) FROM Product p");
    }

    public Long totalProductDetails() {
        return count("SELECT COUNT(pd) FROM ProductDetail pd");
    }

    public Long totalOrders() {
        return count("SELECT COUNT(o) FROM Order o");
    }

    public Double totalRevenue() {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COALESCE(SUM(o.totalAmount), 0) " +
                            "FROM Order o WHERE o.paymentStatus = 'PAID'",
                    Double.class
            ).getSingleResult();
        } finally {
            em.close();
        }
    }
}
