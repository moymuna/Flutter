import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/holiday/providers/holiday_providers.dart';
import 'package:my_hrm/features/holiday/data/models/holiday.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class HolidayFormScreen extends ConsumerStatefulWidget {
  const HolidayFormScreen({super.key, this.holidayId});
  final int? holidayId;
  @override
  ConsumerState<HolidayFormScreen> createState() => _HolidayFormScreenState();
}

class _HolidayFormScreenState extends ConsumerState<HolidayFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.holidayId != null) _load();
  }

  Future<void> _load() async {
    final h = await ref.read(holidayByIdProvider(widget.holidayId!).future);
    _nameController.text = h.name;
    _dateController.text = h.date;
    _descriptionController.text = h.description ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(holidayRepositoryProvider);
      final dto = HolidayRequest(
        name: _nameController.text,
        date: _dateController.text,
        description: _descriptionController.text,
      );
      if (widget.holidayId == null) {
        await repo.create(dto);
      } else {
        await repo.update(widget.holidayId!, dto);
      }
      ref.invalidate(holidaysProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Holiday saved')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.holidayId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Holiday' : 'New Holiday')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _nameController,
              label: 'Name',
              prefixIcon: Icons.event,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _dateController,
              label: 'Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              prefixIcon: Icons.description,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            LoadingButton(
              label: isEdit ? 'Update' : 'Create',
              loading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
