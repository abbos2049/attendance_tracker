import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/attendance.dart';
import '../providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  final Student student;

  AttendanceHistoryScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance History for ${student.name}')),
      body: Consumer<AttendanceProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<Attendance>>(
            future: provider.fetchAttendance(student.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No attendance records found.'));
              } else {
                final attendanceRecords = snapshot.data!;
                return ListView.builder(
                  itemCount: attendanceRecords.length,
                  itemBuilder: (context, index) {
                    final attendance = attendanceRecords[index];
                    return ListTile(
                      title: Text(
                        '${attendance.date.toLocal()}'.split(' ')[0],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        attendance.isPresent ? 'Present' : 'Absent',
                        style: TextStyle(
                          color: attendance.isPresent
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
