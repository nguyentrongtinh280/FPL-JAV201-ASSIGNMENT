package service;

import entity.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    Map<String, String> create(User user, String confirmPassword);
    Map<String, String> update(User user, String confirmPassword);
    void delete(String userId);

    List<User> findAll();
    User findById(String userId);

    List<User> search(String keyword);
}
