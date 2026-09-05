import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/location/providers/location_providers.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class AddressFormWidget extends ConsumerStatefulWidget {
  const AddressFormWidget({
    super.key,
    this.addressLine1,
    this.addressLine2,
    this.postOffice,
    this.postalCode,
    this.countryId,
    this.divisionId,
    this.districtId,
    this.policeStationId,
    this.onAddressLine1Changed,
    this.onAddressLine2Changed,
    this.onPostOfficeChanged,
    this.onPostalCodeChanged,
    this.onCountryChanged,
    this.onDivisionChanged,
    this.onDistrictChanged,
    this.onPoliceStationChanged,
    this.enabled = true,
    this.label,
  });

  final String? addressLine1;
  final String? addressLine2;
  final String? postOffice;
  final String? postalCode;
  final int? countryId;
  final int? divisionId;
  final int? districtId;
  final int? policeStationId;
  final ValueChanged<String>? onAddressLine1Changed;
  final ValueChanged<String>? onAddressLine2Changed;
  final ValueChanged<String>? onPostOfficeChanged;
  final ValueChanged<String>? onPostalCodeChanged;
  final ValueChanged<int?>? onCountryChanged;
  final ValueChanged<int?>? onDivisionChanged;
  final ValueChanged<int?>? onDistrictChanged;
  final ValueChanged<int?>? onPoliceStationChanged;
  final bool enabled;
  final String? label;

  @override
  ConsumerState<AddressFormWidget> createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends ConsumerState<AddressFormWidget> {
  int? _selectedCountryId;
  int? _selectedDivisionId;
  int? _selectedDistrictId;
  int? _selectedPoliceStationId;

  @override
  void initState() {
    super.initState();
    _selectedCountryId = widget.countryId;
    _selectedDivisionId = widget.divisionId;
    _selectedDistrictId = widget.districtId;
    _selectedPoliceStationId = widget.policeStationId;
  }

  @override
  void didUpdateWidget(AddressFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryId != oldWidget.countryId) {
      _selectedCountryId = widget.countryId;
    }
    if (widget.divisionId != oldWidget.divisionId) {
      _selectedDivisionId = widget.divisionId;
    }
    if (widget.districtId != oldWidget.districtId) {
      _selectedDistrictId = widget.districtId;
    }
    if (widget.policeStationId != oldWidget.policeStationId) {
      _selectedPoliceStationId = widget.policeStationId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final countriesAsync = ref.watch(countriesProvider);
    final divisionsAsync = _selectedCountryId != null
        ? ref.watch(divisionsProvider(_selectedCountryId!))
        : null;
    final districtsAsync = _selectedDivisionId != null
        ? ref.watch(districtsProvider(_selectedDivisionId!))
        : null;
    final policeStationsAsync = _selectedDistrictId != null
        ? ref.watch(policeStationsProvider(_selectedDistrictId!))
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),

        // Address Line 1
        TextFormField(
          initialValue: widget.addressLine1,
          enabled: widget.enabled,
          decoration: const InputDecoration(
            labelText: 'Address Line 1',
            prefixIcon: Icon(Icons.home_outlined, size: 20),
          ),
          onChanged: widget.onAddressLine1Changed,
        ),
        const SizedBox(height: 16),

        // Address Line 2
        TextFormField(
          initialValue: widget.addressLine2,
          enabled: widget.enabled,
          decoration: const InputDecoration(
            labelText: 'Address Line 2',
            prefixIcon: Icon(Icons.home_outlined, size: 20),
          ),
          onChanged: widget.onAddressLine2Changed,
        ),
        const SizedBox(height: 16),

        // Country Dropdown
        countriesAsync.when(
          data: (countries) => DropdownButtonFormField<int>(
            initialValue: _selectedCountryId,
            decoration: const InputDecoration(
              labelText: 'Country',
              prefixIcon: Icon(Icons.flag_outlined, size: 20),
            ),
            items: countries.map((c) {
              return DropdownMenuItem<int>(
                value: c.id,
                child: Text(c.countryName),
              );
            }).toList(),
            onChanged: widget.enabled
                ? (val) {
                    setState(() {
                      _selectedCountryId = val;
                      _selectedDivisionId = null;
                      _selectedDistrictId = null;
                      _selectedPoliceStationId = null;
                    });
                    widget.onCountryChanged?.call(val);
                  }
                : null,
          ),
          loading: () => const LinearProgressIndicator(),
          error: (e, _) => Text('Error loading countries: $e'),
        ),
        const SizedBox(height: 16),

        // Division Dropdown
        if (_selectedCountryId != null && divisionsAsync != null)
          divisionsAsync.when(
            data: (divisions) => DropdownButtonFormField<int>(
              initialValue: _selectedDivisionId,
              decoration: const InputDecoration(
                labelText: 'Division',
                prefixIcon: Icon(Icons.map_outlined, size: 20),
              ),
              items: divisions.map((d) {
                return DropdownMenuItem<int>(
                  value: d.id,
                  child: Text(d.name),
                );
              }).toList(),
              onChanged: widget.enabled
                  ? (val) {
                      setState(() {
                        _selectedDivisionId = val;
                        _selectedDistrictId = null;
                        _selectedPoliceStationId = null;
                      });
                      widget.onDivisionChanged?.call(val);
                    }
                  : null,
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('Error loading divisions: $e'),
          ),
        if (_selectedCountryId != null) const SizedBox(height: 16),

        // District Dropdown
        if (_selectedDivisionId != null && districtsAsync != null)
          districtsAsync.when(
            data: (districts) => DropdownButtonFormField<int>(
              initialValue: _selectedDistrictId,
              decoration: const InputDecoration(
                labelText: 'District',
                prefixIcon: Icon(Icons.location_city_outlined, size: 20),
              ),
              items: districts.map((d) {
                return DropdownMenuItem<int>(
                  value: d.id,
                  child: Text(d.districtsName),
                );
              }).toList(),
              onChanged: widget.enabled
                  ? (val) {
                      setState(() {
                        _selectedDistrictId = val;
                        _selectedPoliceStationId = null;
                      });
                      widget.onDistrictChanged?.call(val);
                    }
                  : null,
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('Error loading districts: $e'),
          ),
        if (_selectedDivisionId != null) const SizedBox(height: 16),

        // Police Station Dropdown
        if (_selectedDistrictId != null && policeStationsAsync != null)
          policeStationsAsync.when(
            data: (stations) => DropdownButtonFormField<int>(
              initialValue: _selectedPoliceStationId,
              decoration: const InputDecoration(
                labelText: 'Police Station',
                prefixIcon: Icon(Icons.local_police_outlined, size: 20),
              ),
              items: stations.map((ps) {
                return DropdownMenuItem<int>(
                  value: ps.id,
                  child: Text(ps.name),
                );
              }).toList(),
              onChanged: widget.enabled
                  ? (val) {
                      setState(() => _selectedPoliceStationId = val);
                      widget.onPoliceStationChanged?.call(val);
                    }
                  : null,
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => Text('Error loading police stations: $e'),
          ),
        if (_selectedDistrictId != null) const SizedBox(height: 16),

        // Post Office + Postal Code row
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.postOffice,
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'Post Office',
                  prefixIcon: Icon(Icons.markunread_mailbox_outlined, size: 20),
                ),
                onChanged: widget.onPostOfficeChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                initialValue: widget.postalCode,
                enabled: widget.enabled,
                decoration: const InputDecoration(
                  labelText: 'Postal Code',
                  prefixIcon: Icon(Icons.pin_outlined, size: 20),
                ),
                onChanged: widget.onPostalCodeChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
