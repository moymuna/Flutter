import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/employee_models.dart';
import '../models/metadata_models.dart';
import '../models/enums.dart';
import '../services/employee_service.dart';
import '../services/metadata_service.dart';

class EmployeeFormPage extends StatefulWidget {
  final EmployeeResponse? employee;
  const EmployeeFormPage({super.key, this.employee});

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _metadataService = MetadataService();
  final _employeeService = EmployeeService();
  
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contractController = TextEditingController();
  final _codeController = TextEditingController();
  
  // Selection
  EmployeeStatus _status = EmployeeStatus.active;
  Gender _gender = Gender.male;
  EmploymentType _type = EmploymentType.fullTime;
  int? _selectedDept;
  
  List<DepartmentResponse> _depts = [];
  
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadMetadata();
    if (widget.employee != null) {
      _nameController.text = widget.employee!.fullName ?? "";
      _emailController.text = widget.employee!.email ?? "";
      _contractController.text = widget.employee!.contractNo ?? "";
      _codeController.text = widget.employee!.employeeCode ?? "";
      _status = widget.employee!.status ?? EmployeeStatus.active;
      _gender = widget.employee!.gender ?? Gender.male;
      _type = widget.employee!.employmentType ?? EmploymentType.fullTime;
    }
  }

  Future<void> _loadMetadata() async {
    final depts = await _metadataService.getDepartments();
    if (mounted) {
      setState(() {
        _depts = depts;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);
      
      final employeeData = {
        'fullName': _nameController.text,
        'email': _emailController.text,
        'contractNo': _contractController.text,
        'employeeCode': _codeController.text,
        'status': _status.name.toUpperCase(),
        'gender': _gender.name.toUpperCase(),
        'employmentType': _type.name.toUpperCase(),
        'departmentId': _selectedDept,
      };

      final success = await _employeeService.saveEmployee(employeeData, _imageFile);

      setState(() => _isSaving = false);

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Employee saved successfully!")));
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to save employee.")));
        }
      }
    }
  }

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.employee == null ? "Add Employee" : "Edit Employee")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null ? const Icon(Icons.add_a_photo, size: 40) : null,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<Gender>(
                initialValue: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: Gender.values.map((g) => DropdownMenuItem(value: g, child: Text(g.name))).toList(),
                onChanged: (v) => setState(() => _gender = v!),
              ),
              DropdownButtonFormField<EmploymentType>(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Employment Type'),
                items: EmploymentType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name))).toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
              DropdownButtonFormField<int>(
                initialValue: _selectedDept,
                decoration: const InputDecoration(labelText: 'Department'),
                items: _depts.map((d) => DropdownMenuItem(value: d.id, child: Text(d.departmentName ?? ""))).toList(),
                onChanged: (v) => setState(() => _selectedDept = v),
              ),
              const SizedBox(height: 32),
              _isSaving 
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                    child: const Text("Save Employee"),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
