import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/notice/data/notice_repository.dart';
import 'package:my_hrm/features/notice/data/models/notice.dart';

final noticeRepositoryProvider = Provider<NoticeRepository>((ref) {
  return NoticeRepository(ref.watch(apiClientProvider));
});

final noticesProvider = FutureProvider<List<NoticeResponse>>((ref) async {
  final repo = ref.watch(noticeRepositoryProvider);
  return repo.getAll();
});

final noticeByIdProvider =
    FutureProvider.family<NoticeResponse, int>((ref, id) async {
  final repo = ref.watch(noticeRepositoryProvider);
  return repo.getById(id);
});
