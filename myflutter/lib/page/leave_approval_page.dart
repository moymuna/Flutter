import 'package:flutter/material.dart';
import '../services/leave_service.dart';
import '../models/hrm_models.dart';
import 'package:intl/intl.dart';

class LeaveApprovalPage extends StatefulWidget {
  const LeaveApprovalPage({super.key});

  @override
  State<LeaveApprovalPage> createState() => _LeaveApprovalPageState();
}

class _LeaveApprovalPageState extends State<LeaveApprovalPage> {
  final LeaveService _leaveService = LeaveService();
  List<LeaveResponse> _pendingLeaves = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPendingLeaves();
  }

  Future<void> _loadPendingLeaves() async {
    final allLeaves = await _leaveService.getAllLeavesForApproval();
    if (mounted) {
      setState(() {
        _pendingLeaves = allLeaves.where((l) => l.status == 'PENDING').toList();
        _isLoading = false;
      });
    }
  }

  void _handleAction(int leaveId, bool approve) async {
    bool success = false;
    if (approve) {
      success = await _leaveService.approveLeave(leaveId);
    } else {
      // For simplicity, just using a dummy reason
      success = await _leaveService.rejectLeave(leaveId, "Rejected by manager");
    }

    if (success) {
      _loadPendingLeaves();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(approve ? "Leave Approved" : "Leave Rejected")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pending Leave Approvals")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _pendingLeaves.isEmpty
              ? const Center(child: Text("No pending requests"))
              : ListView.builder(
                  itemCount: _pendingLeaves.length,
                  itemBuilder: (context, index) {
                    final leave = _pendingLeaves[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(leave.employeeName ?? "Unknown Employee"),
                            subtitle: Text("${leave.leaveTypeName}\n${DateFormat('MMM d').format(leave.startDate!)} - ${DateFormat('MMM d').format(leave.endDate!)}\nReason: ${leave.reason}"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => _handleAction(leave.id!, false),
                                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                                  child: const Text("Reject"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () => _handleAction(leave.id!, true),
                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                                  child: const Text("Approve"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
