import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/attendance_service.dart';
import '../models/hrm_models.dart';
import 'package:intl/intl.dart';

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({super.key});

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  final AttendanceService _attendanceService = AttendanceService();
  AttendanceResponse? _todayAttendance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodayAttendance();
  }

  Future<void> _loadTodayAttendance() async {
    final employee = Provider.of<AuthProvider>(context, listen: false).employee;
    if (employee?.id != null) {
      final attendance = await _attendanceService.getTodayAttendance(employee!.id!);
      if (mounted) {
        setState(() {
          _todayAttendance = attendance;
          _isLoading = false;
        });
      }
    }
  }

  void _clockIn() async {
    final employee = Provider.of<AuthProvider>(context, listen: false).employee;
    if (employee?.id != null) {
      final res = await _attendanceService.clockIn(employee!.id!);
      if (res != null) _loadTodayAttendance();
    }
  }

  void _clockOut() async {
    final employee = Provider.of<AuthProvider>(context, listen: false).employee;
    if (employee?.id != null) {
      final res = await _attendanceService.clockOut(employee!.id!);
      if (res != null) _loadTodayAttendance();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LinearProgressIndicator();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Today's Attendance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("Clock In"),
                    Text(_todayAttendance?.checkInTime != null 
                      ? DateFormat.jm().format(_todayAttendance!.checkInTime!) 
                      : "--:--", 
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    const Text("Clock Out"),
                    Text(_todayAttendance?.checkOutTime != null 
                      ? DateFormat.jm().format(_todayAttendance!.checkOutTime!) 
                      : "--:--", 
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _todayAttendance?.checkInTime == null ? _clockIn : null,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    child: const Text("Clock In"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: (_todayAttendance?.checkInTime != null && _todayAttendance?.checkOutTime == null) ? _clockOut : null,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                    child: const Text("Clock Out"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
