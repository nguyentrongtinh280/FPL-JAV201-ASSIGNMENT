package service;

import entity.Category;

import java.util.List;

public interface CategoryService {

    List<Category> findAll();
    List<Category> search(String keyword);

    Category findById(String categoryId);

    void create(Category category);
    void update(Category category);
    void delete(String categoryId);

}