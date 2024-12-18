import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';
import '../models/student.dart';
import 'attendance_screen.dart';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String _searchQuery = '';
  bool _isAscending = true;

  @override
  Widget build(BuildContext context) {
    // Fetch students when the screen loads
    Provider.of<AttendanceProvider>(context, listen: false).fetchStudents();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() {
                _isAscending = !_isAscending;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Students...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Consumer<AttendanceProvider>(
              builder: (context, provider, child) {
                // Filter and sort students
                var students = provider.students;
                if (_searchQuery.isNotEmpty) {
                  students = students
                      .where((student) =>
                          student.name.toLowerCase().contains(_searchQuery.toLowerCase()))
                      .toList();
                }
                students.sort((a, b) => _isAscending
                    ? a.name.compareTo(b.name)
                    : b.name.compareTo(a.name));

                if (students.isEmpty) {
                  return const Center(
                    child: Text('No students found.'),
                  );
                }

                return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            student.name[0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(student.name),
                        subtitle: Text('ID: ${student.id}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AttendanceScreen(student: student),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
