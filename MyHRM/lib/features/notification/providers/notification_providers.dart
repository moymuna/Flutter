import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/notification/data/notification_repository.dart';
import 'package:my_hrm/features/notification/data/models/notification.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository(ref.watch(apiClientProvider));
});

final myNotificationsProvider =
    FutureProvider<List<NotificationResponse>>((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getMine();
});

final unreadCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getUnreadCount();
});
