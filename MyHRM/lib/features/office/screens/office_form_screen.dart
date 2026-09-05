import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/office/providers/office_providers.dart';
import 'package:my_hrm/features/office/data/models/office.dart';
import 'package:my_hrm/features/location/widgets/address_form_widget.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/network/api_error_handler.dart';

class OfficeFormScreen extends ConsumerStatefulWidget {
  const OfficeFormScreen({super.key, this.officeId});

  final int? officeId;

  @override
  ConsumerState<OfficeFormScreen> createState() => _OfficeFormScreenState();
}

class _OfficeFormScreenState extends ConsumerState<OfficeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  bool _loading = false;
  String? _error;

  // Address fields
  String? _addressLine1;
  String? _addressLine2;
  String? _postOffice;
  String? _postalCode;
  int? _policeStationId;

  bool get isEditing => widget.officeId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _loadOffice();
    }
  }

  Future<void> _loadOffice() async {
    final office =
        await ref.read(officeByIdProvider(widget.officeId!).future);
    _nameCtrl.text = office.officeName;
    _codeCtrl.text = office.officeCode;
    _phoneCtrl.text = office.phone ?? '';
    _emailCtrl.text = office.email ?? '';
    if (office.address != null) {
      _addressLine1 = office.address!.addressLine1;
      _addressLine2 = office.address!.addressLine2;
      _postOffice = office.address!.postOffice;
      _postalCode = office.address!.postalCode;
      _policeStationId = office.address!.policeStationId;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(officeRepositoryProvider);
      final dto = OfficeRequest(
        officeName: _nameCtrl.text.trim(),
        officeCode: _codeCtrl.text.trim(),
        phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
        email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        addressLine1: _addressLine1,
        addressLine2: _addressLine2,
        postOffice: _postOffice,
        postalCode: _postalCode,
        policeStationId: _policeStationId,
      );

      if (isEditing) {
        await repo.update(widget.officeId!, dto);
      } else {
        await repo.create(dto);
      }

      if (!mounted) return;
      ref.invalidate(officesProvider);
      ref.invalidate(filteredOfficesProvider);
      context.pop();
    } catch (e) {
      setState(() => _error = apiErrorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Office' : 'New Office'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null) ErrorBanner(message: _error!),
                  AppTextField(
                    label: 'Office Name',
                    controller: _nameCtrl,
                    prefixIcon: Icons.business_outlined,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Office Code',
                    controller: _codeCtrl,
                    prefixIcon: Icons.code_outlined,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Phone',
                    controller: _phoneCtrl,
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Email',
                    controller: _emailCtrl,
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  AddressFormWidget(
                    label: 'Office Address',
                    addressLine1: _addressLine1,
                    addressLine2: _addressLine2,
                    postOffice: _postOffice,
                    postalCode: _postalCode,
                    onAddressLine1Changed: (v) => _addressLine1 = v,
                    onAddressLine2Changed: (v) => _addressLine2 = v,
                    onPostOfficeChanged: (v) => _postOffice = v,
                    onPostalCodeChanged: (v) => _postalCode = v,
                    onPoliceStationChanged: (v) => _policeStationId = v,
                  ),
                  const SizedBox(height: 32),
                  LoadingButton(
                    label: isEditing ? 'Update Office' : 'Create Office',
                    loading: _loading,
                    icon: isEditing ? Icons.save : Icons.add,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
