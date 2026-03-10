package service;

import dao.UserDAO;
import dao.UserDAOImpl;
import entity.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public Map<String, String> create(User user, String confirmPassword) {
        Map<String, String> errors = new HashMap<>();

        if (userDAO.existsByUsername(user.getUsername())) {
            errors.put("username", "Tên đăng nhập đã tồn tại");
        }

        if (userDAO.existsByEmail(user.getEmail())) {
            errors.put("email", "Email đã tồn tại");
        }

        if (user.getPhone() != null && userDAO.existsByPhone(user.getPhone())) {
            errors.put("errorPhone", "Số điện thoại đã tồn tại");
        }

        if (!confirmPassword.equals(user.getPassword())) {
            errors.put("password", "Mật khẩu không khớp");
        }

        if (errors.isEmpty()) {
            userDAO.createUser(user);
        }
        return errors;
    }


    @Override
    public Map<String, String> update(User user, String confirmPassword) {
        Map<String, String> errors = new HashMap<>();
        User oldUser = userDAO.findUserById(user.getUserId());

        if(!user.getEmail().equals(oldUser.getEmail()) && userDAO.existsByEmail(user.getEmail())) {
            errors.put("email", "Email đã tồn tại");
        }

        if (!user.getPhone().equals(oldUser.getPhone()) && userDAO.existsByPhone(user.getPhone())) {
            errors.put("errorPhone", "Số điện thoại đã tồn tại");
        }

        if (!confirmPassword.equals(user.getPassword())) {
            errors.put("password", "Mật khẩu không khớp");
        }

        if (errors.isEmpty()) {
            userDAO.updateUser(user);
        }

        return errors;
    }

    @Override
    public void delete(String userId) {
        userDAO.deleteUser(userId);
    }

    @Override
    public User findById(String userId) {
        return userDAO.findUserById(userId);
    }

    @Override
    public List<User> findAll() {
        return userDAO.getAllUsers();
    }

    @Override
    public List<User> search(String keyword) {
        return userDAO.findByUsernameOrPhone(keyword);
    }
}
