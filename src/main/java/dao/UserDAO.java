package dao;

import entity.User;

import java.util.List;

public interface UserDAO {
    void createUser(User user);
    void updateUser(User user);
    void deleteUser(String userId);
//    User findUserByUsername(String username);
//    User findUserByEmail(String email);

    List<User> getAllUsers();

    User login(String usernameOrEmail, String password);

    User findUserById(String UsernameOrPhone);
}
