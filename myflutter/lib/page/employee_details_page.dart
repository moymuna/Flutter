import 'package:flutter/material.dart';
import '../models/employee_models.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final EmployeeResponse employee;
  const EmployeeDetailsPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(employee.fullName ?? "Employee Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: employee.image != null ? NetworkImage(employee.image!) : null,
                child: employee.image == null ? const Icon(Icons.person, size: 60) : null,
              ),
            ),
            const SizedBox(height: 24),
            _buildDetailRow("Full Name", employee.fullName),
            _buildDetailRow("Email", employee.email),
            _buildDetailRow("Code", employee.employeeCode),
            _buildDetailRow("Department", employee.departmentName),
            _buildDetailRow("Designation", employee.designationTitle),
            _buildDetailRow("Office", employee.officeName),
            _buildDetailRow("Status", employee.status?.name),
            _buildDetailRow("Gender", employee.gender?.name),
            _buildDetailRow("Joining Date", employee.joiningDate?.toString().split(' ')[0]),
            const SizedBox(height: 20),
            const Divider(),
            const Text("Address Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildDetailRow("Present", employee.presentAddress?.addressLine1),
            _buildDetailRow("Permanent", employee.permanentAddress?.addressLine1),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
          Text(value ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
