import 'package:flutter/material.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabel,
    this.selectedValue,
    this.onChanged,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
    this.isDense = false,
  });

  final String label;
  final List<T> items;
  final String Function(T) itemLabel;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(dynamic)? validator;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: selectedValue,
      onChanged: enabled ? onChanged : null,
      isDense: isDense,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(
            itemLabel(item),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      validator: validator != null
          ? (value) => validator!(value)
          : null,
    );
  }
}

class AppEnumDropdown<T extends Enum> extends StatelessWidget {
  const AppEnumDropdown({
    super.key,
    required this.label,
    required this.values,
    required this.displayName,
    this.selectedValue,
    this.onChanged,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
  });

  final String label;
  final List<T> values;
  final String Function(T) displayName;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: selectedValue,
      onChanged: enabled ? onChanged : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
      ),
      items: values.map((value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(displayName(value)),
        );
      }).toList(),
      validator: validator != null
          ? (value) => validator!(value)
          : null,
    );
  }
}

class SearchableDropdown<T> extends StatefulWidget {
  const SearchableDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabel,
    this.selectedValue,
    this.onChanged,
    this.hint,
    this.prefixIcon,
    this.enabled = true,
    this.validator,
    this.isLoading = false,
    this.onSearch,
  });

  final String label;
  final List<T> items;
  final String Function(T) itemLabel;
  final T? selectedValue;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final IconData? prefixIcon;
  final bool enabled;
  final String? Function(dynamic)? validator;
  final bool isLoading;
  final ValueChanged<String>? onSearch;

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items) {
      _filteredItems = widget.items;
      _updateOverlay();
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _updateOverlay() {
    _overlayEntry?.markNeedsBuild();
  }

  void _showOverlay() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _buildOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 50),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 250),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        isDense: true,
                        prefixIcon: Icon(Icons.search, size: 18),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _filteredItems = widget.items
                              .where((item) => widget
                                  .itemLabel(item)
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                        widget.onSearch?.call(value);
                        _updateOverlay();
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final isSelected = item == widget.selectedValue;
                        return ListTile(
                          dense: true,
                          title: Text(widget.itemLabel(item)),
                          selected: isSelected,
                          selectedTileColor:
                              AppColors.primary.withValues(alpha: 0.1),
                          onTap: () {
                            widget.onChanged?.call(item);
                            _controller.text = widget.itemLabel(item);
                            _focusNode.unfocus();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        readOnly: true,
        enabled: widget.enabled,
        validator: widget.validator != null
            ? (value) => widget.validator!(value)
            : null,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint ?? 'Select...',
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 20) : null,
          suffixIcon: widget.isLoading
              ? const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : const Icon(Icons.arrow_drop_down),
        ),
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          } else {
            _focusNode.requestFocus();
          }
        },
      ),
    );
  }
}
