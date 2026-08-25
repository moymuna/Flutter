import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/payroll_service.dart';
import '../models/payroll_models.dart';
import 'package:intl/intl.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  final PayrollService _payrollService = PayrollService();
  SalaryResponse? _salaryStructure;
  List<PayrollResponse> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final employee = Provider.of<AuthProvider>(context, listen: false).employee;
    if (employee?.id != null) {
      final structure = await _payrollService.getMySalaryStructure(employee!.id!);
      final history = await _payrollService.getMyPayrollHistory(employee.id!);
      if (mounted) {
        setState(() {
          _salaryStructure = structure;
          _history = history;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Salary & Payroll"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Structure"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildStructureTab(),
                  _buildHistoryTab(),
                ],
              ),
      ),
    );
  }

  Widget _buildStructureTab() {
    if (_salaryStructure == null) return const Center(child: Text("No salary structure defined"));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Current Salary Breakdown", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              _buildSalaryRow("Basic Salary", _salaryStructure!.basicSalary),
              _buildSalaryRow("House Rent", _salaryStructure!.houseRent),
              _buildSalaryRow("Medical Allowance", _salaryStructure!.medicalAllowance),
              _buildSalaryRow("Conveyance", _salaryStructure!.conveyanceAllowance),
              _buildSalaryRow("Other Allowances", _salaryStructure!.otherAllowances),
              const Divider(),
              _buildSalaryRow("Gross Salary", _salaryStructure!.grossSalary, isTotal: true),
              const SizedBox(height: 16),
              Text("Effective Date: ${_salaryStructure!.effectiveDate ?? 'N/A'}", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalaryRow(String label, double? value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 16 : 14)),
          Text(
            NumberFormat.currency(symbol: '\$').format(value ?? 0.0),
            style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 16 : 14, color: isTotal ? Colors.blue : Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    if (_history.isEmpty) return const Center(child: Text("No payroll history found"));

    return ListView.builder(
      itemCount: _history.length,
      itemBuilder: (context, index) {
        final item = _history[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(DateFormat('MMMM yyyy').format(DateTime(item.year!, item.month!))),
            subtitle: Text("Net Paid: ${NumberFormat.currency(symbol: '\$').format(item.netSalary ?? 0.0)}"),
            trailing: Chip(
              label: Text(item.status ?? 'GENERATED', style: const TextStyle(fontSize: 10, color: Colors.white)),
              backgroundColor: item.status == 'PAID' ? Colors.green : Colors.orange,
            ),
          ),
        );
      },
    );
  }
}
