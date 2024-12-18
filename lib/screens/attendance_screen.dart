import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:attendance_tracker/models/student.dart';
import 'package:attendance_tracker/providers/attendance_provider.dart';

class AttendanceScreen extends StatefulWidget {
  final Student student;

  const AttendanceScreen({Key? key, required this.student}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    Provider.of<AttendanceProvider>(context, listen: false).addMockAttendance(widget.student.id);
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final attendanceRecords = attendanceProvider.attendanceRecords;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.student.name} - Attendance'),
      ),
      body: Column(
        children: [
          // Display attendance records as a table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Status')),
                ],
                rows: attendanceRecords.map((record) {
                  return DataRow(
                    cells: [
                      DataCell(Text(record.date.toString().split(' ')[0])), // Format the date
                      DataCell(Text(record.status)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Form to add custom attendance
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Enter Date (yyyy-mm-dd)',
                  ),
                ),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(
                    labelText: 'Enter Status (Present/Absent)',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final date = DateTime.tryParse(_dateController.text);
                    final status = _statusController.text.trim();

                    if (date != null && (status == 'Present' || status == 'Absent')) {
                      // Add the custom attendance entry
                      attendanceProvider.addCustomAttendance(widget.student.id, date, status);

                      // Clear input fields
                      _dateController.clear();
                      _statusController.clear();
                    } else {
                      // Show an error if the date or status is invalid
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter valid date and status')),
                      );
                    }
                  },
                  child: Text('Add Custom Attendance'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
