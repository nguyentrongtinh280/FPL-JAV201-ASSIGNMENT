package service;

import dao.CategoryDAO;
import dao.CategoryDAOImpl;
import entity.Category;

import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    public List<Category> findAll() {
        return categoryDAO.findAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDAO.search(keyword);
    }

    @Override
    public Category findById(String categoryId) {
        return categoryDAO.findById(categoryId);
    }

    @Override
    public void create(Category category) {
        categoryDAO.create(category);
    }

    @Override
    public void update(Category category) {
        categoryDAO.update(category);
    }

    @Override
    public void delete(String categoryId) {
        categoryDAO.delete(categoryId);
    }
}