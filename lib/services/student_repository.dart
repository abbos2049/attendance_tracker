import '../models/student.dart';

abstract class StudentRepository {
  List<Student> fetchStudents();
}

class ConcreteStudentRepository extends StudentRepository {
  @override
  List<Student> fetchStudents() {
    return [
      Student(id: 1, name: 'John Doe'),
      Student(id: 2, name: 'Jane Smith'),
    ];
  }
}
