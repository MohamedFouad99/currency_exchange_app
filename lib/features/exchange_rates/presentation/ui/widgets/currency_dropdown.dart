import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import 'drop_down_item.dart';

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
