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
}
