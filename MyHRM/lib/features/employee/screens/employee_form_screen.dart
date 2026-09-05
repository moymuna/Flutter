import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/employee/providers/employee_providers.dart';
import 'package:my_hrm/features/employee/data/models/employee.dart';
import 'package:my_hrm/features/department/providers/department_providers.dart';
import 'package:my_hrm/features/designation/providers/designation_providers.dart';
import 'package:my_hrm/features/office/providers/office_providers.dart';
import 'package:my_hrm/features/location/widgets/address_form_widget.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/widgets/app_date_picker.dart';
import 'package:my_hrm/core/widgets/app_dropdown.dart';
import 'package:my_hrm/core/network/api_error_handler.dart';
import 'package:my_hrm/shared/enums.dart';

class EmployeeFormScreen extends ConsumerStatefulWidget {
  const EmployeeFormScreen({super.key, this.employeeId});

  final int? employeeId;

  @override
  ConsumerState<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends ConsumerState<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _contractNoCtrl = TextEditingController();
  final _bloodGroupCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();
  final _bankBranchCtrl = TextEditingController();
  final _bankAccountNameCtrl = TextEditingController();
  final _bankAccountNumberCtrl = TextEditingController();

  bool _loading = false;
  String? _error;

  int? _departmentId;
  int? _designationId;
  int? _officeId;
  int? _managerId;
  Gender? _gender;
  EmployeeStatus? _status;
  EmploymentType? _employmentType;
  DateTime? _joiningDate;
  DateTime? _dateOfBirth;

  // Address fields
  String? _presentAddressLine1;
  String? _presentAddressLine2;
  String? _presentPostOffice;
  String? _presentPostalCode;
  int? _presentPoliceStationId;
  String? _permanentAddressLine1;
  String? _permanentAddressLine2;
  String? _permanentPostOffice;
  String? _permanentPostalCode;
  int? _permanentPoliceStationId;

  bool get isEditing => widget.employeeId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) _loadEmployee();
  }

  Future<void> _loadEmployee() async {
    final emp =
        await ref.read(employeeByIdProvider(widget.employeeId!).future);
    _fullNameCtrl.text = emp.fullName ?? '';
    _codeCtrl.text = emp.employeeCode ?? '';
    _contractNoCtrl.text = emp.contractNo ?? '';
    _bloodGroupCtrl.text = emp.bloodGroup ?? '';
    _bankNameCtrl.text = emp.bankName ?? '';
    _bankBranchCtrl.text = emp.bankBranch ?? '';
    _bankAccountNameCtrl.text = emp.bankAccountName ?? '';
    _bankAccountNumberCtrl.text = emp.bankAccountNumber ?? '';
    _departmentId = emp.departmentId;
    _designationId = emp.designationId;
    _officeId = emp.officeId;
    _managerId = emp.managerId;
    if (emp.gender != null) {
      _gender = Gender.values.firstWhere(
        (e) => e.name == emp.gender,
        orElse: () => Gender.OTHER,
      );
    }
    if (emp.status != null) {
      _status = EmployeeStatus.values.firstWhere(
        (e) => e.name == emp.status,
        orElse: () => EmployeeStatus.ACTIVE,
      );
    }
    if (emp.employmentType != null) {
      _employmentType = EmploymentType.values.firstWhere(
        (e) => e.name == emp.employmentType,
        orElse: () => EmploymentType.FULL_TIME,
      );
    }
    if (emp.joiningDate != null) {
      _joiningDate = DateTime.tryParse(emp.joiningDate!);
    }
    if (emp.dateOfBirth != null) {
      _dateOfBirth = DateTime.tryParse(emp.dateOfBirth!);
    }
    if (emp.presentAddress != null) {
      _presentAddressLine1 = emp.presentAddress!.addressLine1;
      _presentAddressLine2 = emp.presentAddress!.addressLine2;
      _presentPostOffice = emp.presentAddress!.postOffice;
      _presentPostalCode = emp.presentAddress!.postalCode;
      _presentPoliceStationId = emp.presentAddress!.policeStationId;
    }
    if (emp.permanentAddress != null) {
      _permanentAddressLine1 = emp.permanentAddress!.addressLine1;
      _permanentAddressLine2 = emp.permanentAddress!.addressLine2;
      _permanentPostOffice = emp.permanentAddress!.postOffice;
      _permanentPostalCode = emp.permanentAddress!.postalCode;
      _permanentPoliceStationId = emp.permanentAddress!.policeStationId;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _codeCtrl.dispose();
    _contractNoCtrl.dispose();
    _bloodGroupCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankBranchCtrl.dispose();
    _bankAccountNameCtrl.dispose();
    _bankAccountNumberCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(employeeRepositoryProvider);
      final dto = EmployeeRequest(
        fullName: _fullNameCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        password:
            _passwordCtrl.text.isEmpty ? null : _passwordCtrl.text,
        employeeCode:
            _codeCtrl.text.trim().isEmpty ? null : _codeCtrl.text.trim(),
        contractNo:
            _contractNoCtrl.text.trim().isEmpty ? null : _contractNoCtrl.text.trim(),
        bloodGroup:
            _bloodGroupCtrl.text.trim().isEmpty ? null : _bloodGroupCtrl.text.trim(),
        bankName:
            _bankNameCtrl.text.trim().isEmpty ? null : _bankNameCtrl.text.trim(),
        bankBranch:
            _bankBranchCtrl.text.trim().isEmpty ? null : _bankBranchCtrl.text.trim(),
        bankAccountName:
            _bankAccountNameCtrl.text.trim().isEmpty ? null : _bankAccountNameCtrl.text.trim(),
        bankAccountNumber:
            _bankAccountNumberCtrl.text.trim().isEmpty ? null : _bankAccountNumberCtrl.text.trim(),
        gender: _gender?.name,
        status: _status?.name,
        employmentType: _employmentType?.name,
        joiningDate: _joiningDate?.toIso8601String().split('T').first,
        dateOfBirth: _dateOfBirth?.toIso8601String().split('T').first,
        departmentId: _departmentId,
        designationId: _designationId,
        officeId: _officeId,
        managerId: _managerId,
        presentAddress: AddressRequest(
          addressLine1: _presentAddressLine1,
          addressLine2: _presentAddressLine2,
          postOffice: _presentPostOffice,
          postalCode: _presentPostalCode,
          policeStationId: _presentPoliceStationId,
        ),
        permanentAddress: AddressRequest(
          addressLine1: _permanentAddressLine1,
          addressLine2: _permanentAddressLine2,
          postOffice: _permanentPostOffice,
          postalCode: _permanentPostalCode,
          policeStationId: _permanentPoliceStationId,
        ),
      );

      if (isEditing) {
        await repo.update(widget.employeeId!, dto);
      } else {
        await repo.create(dto);
      }

      if (!mounted) return;
      ref.invalidate(employeesProvider);
      ref.invalidate(filteredEmployeesProvider);
      context.pop();
    } catch (e) {
      setState(() => _error = apiErrorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final departmentsAsync = ref.watch(departmentsProvider);
    final designationsAsync = _departmentId != null
        ? ref.watch(designationsByDepartmentProvider(_departmentId!))
        : ref.watch(designationsProvider);
    final officesAsync = ref.watch(officesProvider);
    final employeesAsync = ref.watch(employeesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Employee' : 'New Employee'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null) ErrorBanner(message: _error!),

                  // ── Account Details ────────────────────
                  SectionHeader(title: 'Account Details', icon: Icons.person),
                  AppTextField(
                    label: 'Full Name',
                    controller: _fullNameCtrl,
                    prefixIcon: Icons.person_outline,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Email',
                    controller: _emailCtrl,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  if (!isEditing) ...[
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Password',
                      controller: _passwordCtrl,
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                    ),
                  ],

                  // ── Employment Details ──────────────────
                  SectionHeader(
                      title: 'Employment Details', icon: Icons.work),
                  AppTextField(
                    label: 'Employee Code',
                    controller: _codeCtrl,
                    prefixIcon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Contract No',
                    controller: _contractNoCtrl,
                    prefixIcon: Icons.description_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppDatePicker(
                    label: 'Joining Date',
                    selectedDate: _joiningDate,
                    onChanged: (d) => setState(() => _joiningDate = d),
                    prefixIcon: Icons.calendar_today,
                  ),
                  const SizedBox(height: 16),
                  AppDatePicker(
                    label: 'Date of Birth',
                    selectedDate: _dateOfBirth,
                    onChanged: (d) => setState(() => _dateOfBirth = d),
                    prefixIcon: Icons.cake_outlined,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppEnumDropdown<Gender>(
                          label: 'Gender',
                          values: Gender.values,
                          displayName: (g) => g.displayName,
                          selectedValue: _gender,
                          onChanged: (v) => setState(() => _gender = v),
                          prefixIcon: Icons.wc_outlined,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppEnumDropdown<EmployeeStatus>(
                          label: 'Status',
                          values: EmployeeStatus.values,
                          displayName: (s) => s.displayName,
                          selectedValue: _status,
                          onChanged: (v) => setState(() => _status = v),
                          prefixIcon: Icons.flag_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppEnumDropdown<EmploymentType>(
                    label: 'Employment Type',
                    values: EmploymentType.values,
                    displayName: (t) => t.displayName,
                    selectedValue: _employmentType,
                    onChanged: (v) => setState(() => _employmentType = v),
                    prefixIcon: Icons.timer_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Blood Group',
                    controller: _bloodGroupCtrl,
                    prefixIcon: Icons.bloodtype_outlined,
                  ),

                  // ── Organization ────────────────────────
                  SectionHeader(
                      title: 'Organization', icon: Icons.business),
                  departmentsAsync.when(
                    data: (depts) => DropdownButtonFormField<int>(
                      initialValue: _departmentId,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        prefixIcon:
                            Icon(Icons.account_tree_outlined, size: 20),
                      ),
                      items: depts.map((d) {
                        return DropdownMenuItem<int>(
                          value: d.id,
                          child: Text(d.departmentName),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() {
                        _departmentId = v;
                        _designationId = null;
                      }),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 16),
                  designationsAsync.when(
                    data: (dess) => DropdownButtonFormField<int>(
                      initialValue: _designationId,
                      decoration: const InputDecoration(
                        labelText: 'Designation',
                        prefixIcon: Icon(Icons.work_outline, size: 20),
                      ),
                      items: dess.map((d) {
                        return DropdownMenuItem<int>(
                          value: d.id,
                          child: Text(d.title),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _designationId = v),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 16),
                  officesAsync.when(
                    data: (offices) => DropdownButtonFormField<int>(
                      initialValue: _officeId,
                      decoration: const InputDecoration(
                        labelText: 'Office',
                        prefixIcon: Icon(Icons.business_outlined, size: 20),
                      ),
                      items: offices.map((o) {
                        return DropdownMenuItem<int>(
                          value: o.id,
                          child: Text(o.officeName),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _officeId = v),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 16),
                  employeesAsync.when(
                    data: (emps) => DropdownButtonFormField<int>(
                      initialValue: _managerId,
                      decoration: const InputDecoration(
                        labelText: 'Manager',
                        prefixIcon: Icon(Icons.supervisor_account_outlined,
                            size: 20),
                      ),
                      items: emps.map((e) {
                        return DropdownMenuItem<int>(
                          value: e.id,
                          child: Text(e.fullName ?? 'Employee #${e.id}'),
                        );
                      }).toList(),
                      onChanged: (v) => setState(() => _managerId = v),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),

                  // ── Bank Details ────────────────────────
                  SectionHeader(title: 'Bank Details', icon: Icons.account_balance),
                  AppTextField(
                    label: 'Bank Name',
                    controller: _bankNameCtrl,
                    prefixIcon: Icons.account_balance_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Bank Branch',
                    controller: _bankBranchCtrl,
                    prefixIcon: Icons.location_city_outlined,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Account Name',
                    controller: _bankAccountNameCtrl,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Account Number',
                    controller: _bankAccountNumberCtrl,
                    prefixIcon: Icons.credit_card_outlined,
                    keyboardType: TextInputType.number,
                  ),

                  // ── Present Address ─────────────────────
                  SectionHeader(
                      title: 'Present Address', icon: Icons.home),
                  AddressFormWidget(
                    addressLine1: _presentAddressLine1,
                    addressLine2: _presentAddressLine2,
                    postOffice: _presentPostOffice,
                    postalCode: _presentPostalCode,
                    policeStationId: _presentPoliceStationId,
                    onAddressLine1Changed: (v) =>
                        _presentAddressLine1 = v,
                    onAddressLine2Changed: (v) =>
                        _presentAddressLine2 = v,
                    onPostOfficeChanged: (v) => _presentPostOffice = v,
                    onPostalCodeChanged: (v) => _presentPostalCode = v,
                    onPoliceStationChanged: (v) =>
                        _presentPoliceStationId = v,
                  ),

                  // ── Permanent Address ───────────────────
                  SectionHeader(
                      title: 'Permanent Address', icon: Icons.home_outlined),
                  AddressFormWidget(
                    addressLine1: _permanentAddressLine1,
                    addressLine2: _permanentAddressLine2,
                    postOffice: _permanentPostOffice,
                    postalCode: _permanentPostalCode,
                    policeStationId: _permanentPoliceStationId,
                    onAddressLine1Changed: (v) =>
                        _permanentAddressLine1 = v,
                    onAddressLine2Changed: (v) =>
                        _permanentAddressLine2 = v,
                    onPostOfficeChanged: (v) => _permanentPostOffice = v,
                    onPostalCodeChanged: (v) => _permanentPostalCode = v,
                    onPoliceStationChanged: (v) =>
                        _permanentPoliceStationId = v,
                  ),

                  const SizedBox(height: 32),
                  LoadingButton(
                    label: isEditing ? 'Update Employee' : 'Create Employee',
                    loading: _loading,
                    icon: isEditing ? Icons.save : Icons.person_add,
                    onPressed: _save,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
