import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/holiday/data/holiday_repository.dart';
import 'package:my_hrm/features/holiday/data/models/holiday.dart';

final holidayRepositoryProvider = Provider<HolidayRepository>((ref) {
  return HolidayRepository(ref.watch(apiClientProvider));
});

final holidaysProvider = FutureProvider<List<HolidayResponse>>((ref) async {
  final repo = ref.watch(holidayRepositoryProvider);
  return repo.getAll();
});

final holidayByIdProvider =
    FutureProvider.family<HolidayResponse, int>((ref, id) async {
  final repo = ref.watch(holidayRepositoryProvider);
  return repo.getById(id);
});

final upcomingHolidaysProvider =
    FutureProvider.family<List<HolidayResponse>, int>((ref, limit) async {
  final repo = ref.watch(holidayRepositoryProvider);
  return repo.getUpcoming(limit);
});
