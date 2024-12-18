// lib/providers/attendance_provider.dart

import 'package:flutter/material.dart';
import 'package:attendance_tracker/models/student.dart';
import 'package:attendance_tracker/models/attendance.dart';

class AttendanceProvider extends ChangeNotifier {
  // Mock student data
  List<Student> _students = [
    Student(id: 1, name: 'Muxiddinova Farangiz'),
    Student(id: 2, name: 'Aliyev Vali'),
    Student(id: 4, name: 'Valiyeva Ali'),
    Student(id: 5, name: 'Ganiyev Anvar'),
    Student(id: 6, name: 'To\'rayeva O\'lmasoy'),
    Student(id: 7, name: 'Mansurova Anvara'),
    Student(id: 8, name: 'Anvarova Dilnoza'),
    Student(id: 9, name: 'Tursunova Laylo'),
    Student(id: 10, name: 'Rustamova Maftuna'),
    Student(id: 11, name: 'Khudoyberdiyeva Malika'),
    Student(id: 12, name: 'Shodiyeva Gulsara'),
    Student(id: 13, name: 'Mirzaeva Nargiza'),
    Student(id: 14, name: 'Jalilova Munira'),
    Student(id: 15, name: 'Mahmudova Shahnoza'),
    Student(id: 16, name: 'Isakova Nilufar'),
    Student(id: 17, name: 'Abdullayeva Saida'),
    Student(id: 18, name: 'Akhmedova Lola'),
    Student(id: 19, name: 'Vohidova Safiya'),
    Student(id: 20, name: 'Rakhimova Madina'),
    Student(id: 21, name: 'Azizova Gulsina'),
    Student(id: 22, name: 'Xudoyberganova Yasmina'),
    Student(id: 23, name: 'Nizamova Dilorom'),
    Student(id: 24, name: 'Kamilova Maftuna'),
    Student(id: 25, name: 'Babaeva Firuza'),
    Student(id: 26, name: 'Samatova Amina'),
    Student(id: 27, name: 'Nazarova Khurshida'),
  ];


  // Mock attendance data
  List<Attendance> _attendanceRecords = [];

  // Getter to access student records
  List<Student> get students => _students;

  // Getter to access attendance records
  List<Attendance> get attendanceRecords => _attendanceRecords;

  // Add mock attendance data for a student
  void addMockAttendance(int studentId) {
    final now = DateTime.now();
    _attendanceRecords = List.generate(10, (index) {
      return Attendance(
        id: (index + 1).toString(),
        studentId: studentId,
        date: now.subtract(Duration(days: index)),
        status: index % 2 == 0 ? 'Present' : 'Absent',
      );
    });
    notifyListeners();  // Notify listeners that data has changed
  }

  // Add custom attendance
  void addCustomAttendance(int studentId, DateTime date, String status) {
    final newAttendance = Attendance(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      studentId: studentId,
      date: date,
      status: status,
    );
    _attendanceRecords.add(newAttendance);
    notifyListeners();  // Notify listeners about the change
  }

  // Fetch students (this method can be used if you need to fetch data from an API)
  void fetchStudents() {
    // For now, we will simulate fetching data by using the mock data
    notifyListeners();
  }
}
