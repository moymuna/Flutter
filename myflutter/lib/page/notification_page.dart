import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/notification_service.dart';
import '../models/communication_models.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationService _notificationService = NotificationService();
  List<NotificationResponse> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final notifications = await _notificationService.getMyNotifications();
    if (mounted) {
      setState(() {
        _notifications = notifications;
        _isLoading = false;
      });
      // Update unread count in provider
      Provider.of<AuthProvider>(context, listen: false).fetchUnreadCount();
    }
  }

  void _markRead(int id) async {
    await _notificationService.markAsRead(id);
    _loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? const Center(child: Text("No notifications"))
              : ListView.builder(
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final note = _notifications[index];
                    return ListTile(
                      leading: Icon(
                        note.isRead ? Icons.notifications_none : Icons.notifications_active,
                        color: note.isRead ? Colors.grey : Colors.blue,
                      ),
                      title: Text(note.message ?? "", style: TextStyle(fontWeight: note.isRead ? FontWeight.normal : FontWeight.bold)),
                      subtitle: Text(note.createdAt != null ? DateFormat.yMMMd().add_jm().format(note.createdAt!) : ""),
                      onTap: () {
                        if (!note.isRead) _markRead(note.id!);
                      },
                      tileColor: note.isRead ? null : Colors.blue.withValues(alpha: 0.05),
                    );
                  },
                ),
    );
  }
}
