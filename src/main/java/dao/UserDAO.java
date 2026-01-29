package dao;

import entity.User;

import java.util.List;

public interface UserDAO {
    void createUser(User user);
    void updateUser(User user);
    void deleteUser(String userId);
//    User findUserByUsername(String username);
    User findUserById(String userId);

    List<User> getAllUsers();

    User login(String usernameOrEmail, String password);

    List<User> findByUsernameOrPhone(String keyword);

    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);
// Them Phan Gui MA OTP ve Email Da Dang Ki
    User findUserByEmailOrUsername(String emailOrUsername);
    User findByUsername(String username);

    void updatePassword(String username, String newPassword);
}
