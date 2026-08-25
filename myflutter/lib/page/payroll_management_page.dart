import 'package:flutter/material.dart';
import '../services/payroll_service.dart';
import '../models/payroll_models.dart';
import 'package:intl/intl.dart';

class PayrollManagementPage extends StatefulWidget {
  const PayrollManagementPage({super.key});

  @override
  State<PayrollManagementPage> createState() => _PayrollManagementPageState();
}

class _PayrollManagementPageState extends State<PayrollManagementPage> {
  final PayrollService _payrollService = PayrollService();
  List<PayrollResponse> _payrolls = [];
  bool _isLoading = true;
  final int _selectedYear = DateTime.now().year;
  final int _selectedMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    _loadPayrolls();
  }

  Future<void> _loadPayrolls() async {
    setState(() => _isLoading = true);
    final payrolls = await _payrollService.getAllPayrolls();
    if (mounted) {
      setState(() {
        _payrolls = payrolls;
        _isLoading = false;
      });
    }
  }

  void _generatePayroll() async {
    final success = await _payrollService.generatePayroll(_selectedYear, _selectedMonth);
    if (success) {
      _loadPayrolls();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payroll generated for all employees")));
    }
  }

  void _pay(int id) async {
    final success = await _payrollService.payPayroll(id);
    if (success) {
      _loadPayrolls();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Payroll marked as PAID")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payroll Management")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _generatePayroll,
                    icon: const Icon(Icons.settings),
                    label: const Text("Generate Monthly Payroll"),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _payrolls.length,
                    itemBuilder: (context, index) {
                      final item = _payrolls[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(item.employeeName ?? "Unknown"),
                          subtitle: Text("${DateFormat('MMM yyyy').format(DateTime(item.year!, item.month!))} - Net: ${NumberFormat.currency(symbol: '\$').format(item.netSalary ?? 0.0)}"),
                          trailing: item.status == 'PAID'
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : ElevatedButton(
                                  onPressed: () => _pay(item.id!),
                                  child: const Text("Pay"),
                                ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
