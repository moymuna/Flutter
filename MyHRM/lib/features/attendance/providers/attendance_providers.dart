import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/attendance/data/attendance_repository.dart';
import 'package:my_hrm/features/attendance/data/models/attendance.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(ref.watch(apiClientProvider));
});

final allAttendanceProvider =
    FutureProvider<List<AttendanceResponse>>((ref) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getAll();
});

final attendanceSearchProvider = StateProvider<String>((ref) => '');

final filteredAttendanceProvider =
    FutureProvider<List<AttendanceResponse>>((ref) async {
  final keyword = ref.watch(attendanceSearchProvider);
  final repo = ref.watch(attendanceRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final attendanceByIdProvider =
    FutureProvider.family<AttendanceResponse, int>((ref, id) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getById(id);
});

final attendanceByEmployeeProvider = FutureProvider.family<
    List<AttendanceResponse>, Map<String, int>>((ref, params) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getByEmployee(
      params['employeeId']!, params['year']!, params['month']!);
});

final todayAttendanceProvider =
    FutureProvider.family<AttendanceResponse?, int>((ref, employeeId) async {
  final repo = ref.watch(attendanceRepositoryProvider);
  try {
    return repo.getToday(employeeId);
  } catch (_) {
    return null;
  }
});
