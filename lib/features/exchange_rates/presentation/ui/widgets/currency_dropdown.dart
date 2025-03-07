import 'package:flutter/material.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import 'drop_down_item.dart';

// date: 7 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a class that represents a dropdown widget for selecting currencies.
// The class takes various parameters to customize the appearance and behavior of the dropdown.
class CurrencyDropdown extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final Function(String) onChanged;
  final List<String> items;

  const CurrencyDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font14DarkBlueBold),
        verticalSpace(8),
        DropDownItem(
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
          items:
              items.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
          text: label,
          value: selectedValue,
        ),
      ],
    );
  }
}
