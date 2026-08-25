import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/notice_service.dart';
import '../models/communication_models.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/enums.dart';

class NoticeBoardPage extends StatefulWidget {
  const NoticeBoardPage({super.key});

  @override
  State<NoticeBoardPage> createState() => _NoticeBoardPageState();
}

class _NoticeBoardPageState extends State<NoticeBoardPage> {
  final NoticeService _noticeService = NoticeService();
  List<NoticeResponse> _notices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotices();
  }

  Future<void> _loadNotices() async {
    final notices = await _noticeService.getAllNotices();
    if (mounted) {
      setState(() {
        _notices = notices;
        _isLoading = false;
      });
    }
  }

  void _showAddNoticeDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Post New Notice"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
            TextField(controller: descController, decoration: const InputDecoration(labelText: "Description"), maxLines: 3),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              final success = await _noticeService.saveNotice({
                'title': titleController.text,
                'description': descController.text,
                'publishDate': DateTime.now().toIso8601String(),
              });
              if (success) {
                if (context.mounted) {
                  Navigator.pop(context);
                  _loadNotices();
                }
              }
            },
            child: const Text("Post"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userRole = Provider.of<AuthProvider>(context).user?.role;
    final canManage = userRole == Role.admin || userRole == Role.hr;

    return Scaffold(
      appBar: AppBar(title: const Text("Notice Board")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _notices.length,
              itemBuilder: (context, index) {
                final notice = _notices[index];
                return Card(
                  child: ExpansionTile(
                    title: Text(notice.title ?? "No Title", style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(notice.publishDate != null ? DateFormat.yMMMd().format(notice.publishDate!) : ""),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notice.description ?? ""),
                            const SizedBox(height: 10),
                            if (canManage)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () async {
                                    if (await _noticeService.deleteNotice(notice.id!)) _loadNotices();
                                  },
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  label: const Text("Delete", style: TextStyle(color: Colors.red)),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: canManage
          ? FloatingActionButton(
              onPressed: _showAddNoticeDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
