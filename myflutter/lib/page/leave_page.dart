import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/leave_service.dart';
import '../services/metadata_service.dart';
import '../models/hrm_models.dart';
import '../models/metadata_models.dart';
import 'package:intl/intl.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  final LeaveService _leaveService = LeaveService();
  final MetadataService _metadataService = MetadataService();
  
  List<LeaveResponse> _myLeaves = [];
  List<LeaveTypeResponse> _leaveTypes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final employee = Provider.of<AuthProvider>(context, listen: false).employee;
    if (employee?.id != null) {
      final leaves = await _leaveService.getMyLeaves(employee!.id!);
      final types = await _metadataService.getLeaveTypes();
      if (mounted) {
        setState(() {
          _myLeaves = leaves;
          _leaveTypes = types;
          _isLoading = false;
        });
      }
    }
  }

  void _showApplyLeaveForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _ApplyLeaveForm(
        leaveTypes: _leaveTypes,
        onSubmitted: () {
          Navigator.pop(context);
          _loadData();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Management")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _myLeaves.length,
              itemBuilder: (context, index) {
                final leave = _myLeaves[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text("${leave.leaveTypeName} (${leave.totalDays} Days)"),
                    subtitle: Text("${DateFormat('MMM d').format(leave.startDate!)} - ${DateFormat('MMM d').format(leave.endDate!)}\nReason: ${leave.reason}"),
                    trailing: _buildStatusChip(leave.status),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showApplyLeaveForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusChip(String? status) {
    Color color = Colors.grey;
    if (status == 'APPROVED') color = Colors.green;
    if (status == 'REJECTED') color = Colors.red;
    if (status == 'PENDING') color = Colors.orange;

    return Chip(
      label: Text(status ?? 'PENDING', style: const TextStyle(color: Colors.white, fontSize: 12)),
      backgroundColor: color,
    );
  }
}

class _ApplyLeaveForm extends StatefulWidget {
  final List<LeaveTypeResponse> leaveTypes;
  final VoidCallback onSubmitted;

  const _ApplyLeaveForm({required this.leaveTypes, required this.onSubmitted});

  @override
  State<_ApplyLeaveForm> createState() => _ApplyLeaveFormState();
}

class _ApplyLeaveFormState extends State<_ApplyLeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  int? _selectedTypeId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Apply for Leave", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<int>(
              initialValue: _selectedTypeId,
              decoration: const InputDecoration(labelText: 'Leave Type'),
              items: widget.leaveTypes.map((t) => DropdownMenuItem(value: t.id, child: Text(t.name ?? ""))).toList(),
              onChanged: (v) => setState(() => _selectedTypeId = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            ListTile(
              title: const Text("Start Date"),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(_startDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(context: context, initialDate: _startDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                if (date != null) setState(() => _startDate = date);
              },
            ),
            ListTile(
              title: const Text("End Date"),
              subtitle: Text(DateFormat('yyyy-MM-dd').format(_endDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(context: context, initialDate: _endDate, firstDate: _startDate, lastDate: DateTime.now().add(const Duration(days: 365)));
                if (date != null) setState(() => _endDate = date);
              },
            ),
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(labelText: 'Reason'),
              validator: (v) => v!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final employee = Provider.of<AuthProvider>(context, listen: false).employee;
                  final success = await LeaveService().applyLeave({
                    'employeeId': employee!.id,
                    'leaveTypeId': _selectedTypeId,
                    'startDate': _startDate.toIso8601String().split('T')[0],
                    'endDate': _endDate.toIso8601String().split('T')[0],
                    'reason': _reasonController.text,
                  });
                  if (success) widget.onSubmitted();
                }
              },
              child: const Text("Submit Request"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
