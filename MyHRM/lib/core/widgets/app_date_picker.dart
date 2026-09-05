import 'package:flutter/material.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    required this.label,
    this.selectedDate,
    this.onChanged,
    this.firstDate,
    this.lastDate,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.format = 'yyyy-MM-dd',
  });

  final String label;
  final DateTime? selectedDate;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData? prefixIcon;
  final String? Function(DateTime?)? validator;
  final bool enabled;
  final String format;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enabled: enabled,
      validator: (value) {
        if (validator != null) {
          return validator!(selectedDate);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon:
            Icon(prefixIcon ?? Icons.calendar_today, size: 20),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      controller: TextEditingController(
        text: selectedDate != null
            ? DateFormat(format).format(selectedDate!)
            : '',
      ),
      onTap: enabled
          ? () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: firstDate ?? DateTime(2000),
                lastDate: lastDate ?? DateTime(2100),
              );
              if (picked != null) {
                onChanged?.call(picked);
              }
            }
          : null,
    );
  }
}

class AppDateRangePicker extends StatelessWidget {
  const AppDateRangePicker({
    super.key,
    required this.label,
    this.startDate,
    this.endDate,
    this.onStartChanged,
    this.onEndChanged,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
  });

  final String label;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<DateTime?>? onStartChanged;
  final ValueChanged<DateTime?>? onEndChanged;
  final IconData? prefixIcon;
  final String? Function(DateTime?, DateTime?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: AppDatePicker(
                label: 'Start Date',
                selectedDate: startDate,
                onChanged: onStartChanged,
                enabled: enabled,
                prefixIcon: Icons.calendar_today,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.arrow_forward, size: 18, color: AppColors.textMuted),
            ),
            Expanded(
              child: AppDatePicker(
                label: 'End Date',
                selectedDate: endDate,
                onChanged: onEndChanged,
                enabled: enabled,
                prefixIcon: Icons.calendar_today,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
