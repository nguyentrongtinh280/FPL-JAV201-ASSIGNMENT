package dao;

import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import utils.XJPA;
import java.util.List;

public class UserDAOImpl implements UserDAO {

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
            if (user != null) em.remove(user);
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
            return em.createQuery(jpql, User.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public User login(String usernameOrEmail, String password) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE (u.email = :ue OR u.username = :ue) AND u.password = :pw";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("ue", usernameOrEmail);
            query.setParameter("pw", password);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findByUsernameOrPhone(String keyword) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username LIKE :kw OR u.phone LIKE :kw";
            return em.createQuery(jpql, User.class)
                    .setParameter("kw", "%" + keyword + "%")
                    .getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public User findUserById(String userId) {
        EntityManager em = XJPA.getEntityManager();
        try {
            return em.find(User.class, userId);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByUsername(String username) {
        if (username == null || username.isBlank()) {
            return false;
        }

        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.username = :un";
            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("un", username)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }


    @Override
    public boolean existsByEmail(String email) {
        if (email == null || email.isBlank()) {
            return false;
        }

        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :em";
            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("em", email)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByPhone(String phone) {
        if (phone == null || phone.isBlank()) {
            return false;
        }

        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.phone = :ph";
            Long count = em.createQuery(jpql, Long.class)
                    .setParameter("ph", phone)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }


    @Override
    public User findUserByEmailOrUsername(String emailOrUsername) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.email = :eou OR u.username = :eou";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("eou", emailOrUsername);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    // PHẦN BỔ SUNG QUÊN MẬT KHẨU

    @Override
    public User findByUsername(String username) {
        EntityManager em = XJPA.getEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.username = :un";
            TypedQuery<User> query = em.createQuery(jpql, User.class);
            query.setParameter("un", username);
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    @Override
    public void updatePassword(String username, String newPassword) {
        EntityManager em = XJPA.getEntityManager();
        EntityTransaction tr = em.getTransaction();
        try {
            tr.begin();
            String jpql = "UPDATE User u SET u.password = :pw WHERE u.username = :un";
            em.createQuery(jpql)
                    .setParameter("pw", newPassword)
                    .setParameter("un", username)
                    .executeUpdate();
            tr.commit();
        } catch (Exception e) {
            tr.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
