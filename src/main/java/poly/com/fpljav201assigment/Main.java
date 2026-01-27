package poly.com.fpljav201assigment;

import dao.UserDAOImpl;

public class Main {
    public static void main(String[] args) {
        UserDAOImpl dao = new UserDAOImpl();
        dao.getAllUsers().forEach(System.out::println);
    }
}
