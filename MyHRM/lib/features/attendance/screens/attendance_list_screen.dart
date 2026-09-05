import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/attendance/providers/attendance_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/shared/enums.dart';

class AttendanceListScreen extends ConsumerWidget {
  const AttendanceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(filteredAttendanceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search attendance...',
              onChanged: (value) =>
                  ref.read(attendanceSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: attendanceAsync.when(
              data: (records) => ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(record.employeeName ?? 'N/A'),
                      subtitle: Text(
                        '${record.date ?? ''} | ${record.clockIn ?? '--'} - ${record.clockOut ?? '--'}',
                      ),
                      trailing: StatusBadge(
                        label: record.status?.replaceAll('_', ' ') ?? 'N/A',
                        color: _getStatusColor(record.status),
                      ),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    final s = AttendanceStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => AttendanceStatus.PRESENT,
    );
    switch (s) {
      case AttendanceStatus.PRESENT:
        return Colors.green;
      case AttendanceStatus.ABSENT:
        return Colors.red;
      case AttendanceStatus.HALF_DAY:
        return Colors.orange;
      case AttendanceStatus.ON_LEAVE:
        return Colors.blue;
      case AttendanceStatus.HOLIDAY:
        return Colors.purple;
      case AttendanceStatus.WEEK_OFF:
        return Colors.teal;
      case AttendanceStatus.WORK_FROM_HOME:
        return Colors.indigo;
    }
  }
}
