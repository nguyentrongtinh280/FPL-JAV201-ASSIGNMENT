package dao;

import entity.Category;
import java.util.List;

public interface CategoryDAO {

    List<Category> findAll();

    List<Category> search(String keyword);

    Category findById(String id);

    void create(Category category);

    void update(Category category);

    void delete(String id);
}