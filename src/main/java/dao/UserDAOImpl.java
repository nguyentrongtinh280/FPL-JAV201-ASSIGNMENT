package dao;

import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;

import java.util.List;

public class UserDAOImpl implements UserDAO{

    @Override
    public void createUser(User user) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void updateUser(User user) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.merge(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public void deleteUser(String userId) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            User user = em.find(User.class, userId);
            if (user != null) {
                em.remove(user);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> getAllUsers() {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public User login(String usernameOrEmail, String password) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE (u.email = :usernameOrEmail OR u.username = :usernameOrEmail) AND u.password = :password";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("usernameOrEmail", usernameOrEmail);
            query.setParameter("password", password);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public User findUserByUsernameOrPhone(String UsernameOrPhone) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username = :UsernameOrPhone OR u.username = :UsernameOrPhone";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("UsernameOrPhone", UsernameOrPhone);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public User findUserById(String userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.userId = :userId";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByUsername(String username) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.username = :username";
            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("username", username)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByPhone(String phone) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.phone = :phone";
            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("phone", phone)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

}
