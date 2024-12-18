// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_tracker/providers/attendance_provider.dart';
import 'package:attendance_tracker/screens/student_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: MaterialApp(
        title: 'Attendance Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StudentListScreen(),
      ),
    );
  }
}
