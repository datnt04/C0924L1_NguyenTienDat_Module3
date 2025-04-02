package service;

import model.Student;
import repository.StudentRepository;

import java.util.List;

public class StudentService {
    private StudentRepository studentRepository = new StudentRepository();

    public List<Student> getAllStudents() {
        return studentRepository.getAllStudents();
    }
}