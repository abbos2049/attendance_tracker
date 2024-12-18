import '../models/attendance.dart';

class AttendanceRepository {
  final List<Attendance> _attendanceRecords = [];

  List<Attendance> getAttendanceRecords(int studentId) {
    return _attendanceRecords.where((record) => record.studentId == studentId).toList();
  }

  void addAttendance(Attendance attendance) {
    _attendanceRecords.add(attendance);
  }
}
