import 'package:flutter/material.dart';
import '../models/employee_models.dart';
import '../services/employee_service.dart';
import 'employee_form_page.dart';
import 'employee_details_page.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final EmployeeService _employeeService = EmployeeService();
  List<EmployeeResponse> _employees = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  Future<void> _fetchEmployees() async {
    final employees = await _employeeService.getAllEmployees();
    if (mounted) {
      setState(() {
        _employees = employees;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee List")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                final emp = _employees[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(emp.fullName ?? "No Name"),
                  subtitle: Text("${emp.designationTitle ?? ''} - ${emp.departmentName ?? ''}"),
                  trailing: Text(emp.status?.name ?? ""),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployeeDetailsPage(employee: emp)),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployeeFormPage(employee: emp)),
                    ).then((_) => _fetchEmployees());
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EmployeeFormPage()),
          ).then((_) => _fetchEmployees());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
