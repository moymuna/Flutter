import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/notification/providers/notification_providers.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(myNotificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 64, color: AppColors.textMuted),
                  SizedBox(height: 16),
                  Text('No notifications', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final isRead = notification.isRead ?? false;
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                color: isRead ? null : AppColors.primary.withValues(alpha: 0.05),
                child: ListTile(
                  leading: Icon(
                    isRead ? Icons.notifications_none : Icons.notifications_active,
                    color: isRead ? AppColors.textMuted : AppColors.primary,
                  ),
                  title: Text(
                    notification.title ?? 'N/A',
                    style: TextStyle(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    notification.message ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    notification.createdAt ?? '',
                    style: const TextStyle(fontSize: 11),
                  ),
                  onTap: () async {
                    if (!isRead) {
                      final repo = ref.read(notificationRepositoryProvider);
                      await repo.markAsRead(notification.id);
                      ref.invalidate(myNotificationsProvider);
                      ref.invalidate(unreadCountProvider);
                    }
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
