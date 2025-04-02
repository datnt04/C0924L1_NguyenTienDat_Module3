package service;

import model.User;
import repository.UserRepository;

import java.util.List;

public class UserService {
    private final UserRepository userRepository = new UserRepository();

    public int getTotalCustomers() {
        return userRepository.getTotalCustomers();
    }

    public List<User> getAllUsers() {
        return userRepository.getAllUsers();
    }

    public String getUserNameById(int userId) {
        return userRepository.getUserNameById(userId);
    }
}