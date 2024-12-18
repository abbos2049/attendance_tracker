import 'package:flutter/material.dart';
import '../models/student.dart';
import '../providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AddAttendanceScreen extends StatefulWidget {
  final Student student;

  AddAttendanceScreen({required this.student});

  @override
  _AddAttendanceScreenState createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  DateTime? _selectedDate;
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Attendance for ${widget.student.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Date',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _selectedDate != null
                      ? _selectedDate!.toLocal().toString().split(' ')[0]
                      : 'No date selected',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Select Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedStatus,
              hint: Text('Select Attendance Status'),
              items: ['Present', 'Absent']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDate != null && _selectedStatus != null) {
                    Provider.of<AttendanceProvider>(context, listen: false)
                        .addAttendance(
                      studentId: widget.student.id,
                      date: _selectedDate!,
                      status: _selectedStatus!,
                    );
                    Navigator.pop(context); // Return to previous screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select both date and status'),
                      ),
                    );
                  }
                },
                child: Text('Add Attendance'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
