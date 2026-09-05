import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/attendance/providers/attendance_providers.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class ClockInOutWidget extends ConsumerStatefulWidget {
  const ClockInOutWidget({super.key});

  @override
  ConsumerState<ClockInOutWidget> createState() => _ClockInOutWidgetState();
}

class _ClockInOutWidgetState extends ConsumerState<ClockInOutWidget> {
  bool _loading = false;

  Future<void> _clockIn() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(attendanceRepositoryProvider);
      await repo.clockIn(1);
      ref.invalidate(todayAttendanceProvider(1));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Clocked in successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _clockOut() async {
    setState(() => _loading = true);
    try {
      final repo = ref.read(attendanceRepositoryProvider);
      await repo.clockOut(1);
      ref.invalidate(todayAttendanceProvider(1));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Clocked out successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final todayAsync = ref.watch(todayAttendanceProvider(1));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.access_time, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            todayAsync.when(
              data: (attendance) {
                if (attendance == null) {
                  return Column(
                    children: [
                      const Text(
                        'Not clocked in yet',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loading ? null : _clockIn,
                        icon: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.login),
                        label: const Text('Clock In'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Text(
                      'Clocked in at: ${attendance.clockIn ?? '--'}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (attendance.clockOut != null)
                      Text(
                        'Clocked out at: ${attendance.clockOut}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    const SizedBox(height: 16),
                    if (attendance.clockOut == null)
                      ElevatedButton.icon(
                        onPressed: _loading ? null : _clockOut,
                        icon: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.logout),
                        label: const Text('Clock Out'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      )
                    else
                      const Chip(
                        label: Text('Completed'),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                  ],
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, _) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}
