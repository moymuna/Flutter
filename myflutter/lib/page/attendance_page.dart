import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/attendance_service.dart';
import '../models/hrm_models.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final AttendanceService _attendanceService = AttendanceService();
  List<AttendanceResponse> _history = [];
  AttendanceSummary? _summary;
  bool _isLoading = true;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final employee = Provider.of<AuthProvider>(context, listen: false).employee;
    if (employee?.id != null) {
      setState(() => _isLoading = true);
      final history = await _attendanceService.getAttendanceHistory(
          employee!.id!, _selectedDate.year, _selectedDate.month);
      final summary = await _attendanceService.getMonthlySummary(
          employee.id!, _selectedDate.year, _selectedDate.month);
      if (mounted) {
        setState(() {
          _history = history;
          _summary = summary;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Attendance History")),
      body: Column(
        children: [
          _buildMonthPicker(),
          if (_summary != null) _buildSummaryCard(),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      final att = _history[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: att.status == 'PRESENT' ? Colors.green : Colors.red,
                          child: Text(att.date!.day.toString(), style: const TextStyle(color: Colors.white)),
                        ),
                        title: Text(DateFormat('EEEE, MMM d').format(att.date!)),
                        subtitle: Text(att.checkInTime != null 
                          ? "${DateFormat.jm().format(att.checkInTime!)} - ${att.checkOutTime != null ? DateFormat.jm().format(att.checkOutTime!) : '---'}" 
                          : att.status ?? ""),
                        trailing: Text("${att.workedHours?.toStringAsFixed(1) ?? '0'} hrs"),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthPicker() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {
            setState(() => _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1));
            _loadData();
          }),
          Text(DateFormat('MMMM yyyy').format(_selectedDate), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {
            setState(() => _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1));
            _loadData();
          }),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem("Present", _summary!.presentDays.toString(), Colors.green),
            _buildStatItem("Absent", _summary!.absentDays.toString(), Colors.red),
            _buildStatItem("Leave", _summary!.onLeaveDays.toString(), Colors.orange),
            _buildStatItem("Hours", _summary!.totalWorkedHours.toStringAsFixed(1), Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
