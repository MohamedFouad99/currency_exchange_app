import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
// date: 7 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a class that represents a dropdown widget for selecting an item.
// The class takes various parameters to customize the appearance and behavior of the dropdown.

class DropDownItem extends StatelessWidget {
  const DropDownItem({
    super.key,
    required this.onChanged,
    required this.items,
    required this.text,
    required this.value,
  });

  final String? value;
  final String text;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;
  @override
  /// Builds the widget tree for the dropdown item.
  ///
  /// This widget uses a [DropdownButtonFormField] to create a dropdown with the
  /// specified items. The [value] parameter is used to set the initial selected
  /// item, and the [onChanged] parameter is used to notify the parent of changes
  /// to the selected item. The [text] parameter is used to set the hint text
  /// displayed when no item is selected. The dropdown items are displayed in a
  /// menu with a maximum height of 210.h. The dropdown menu is displayed below
  /// the button. The border of the button is an [OutlineInputBorder] with a radius
  /// of 12, and the border color is [ColorsManager.gray]. When the dropdown is
  /// focused, the border color is set to [ColorsManager.secondary]. The dropdown
  /// item is returned in a [SizedBox] with a height of 54.h.
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(text, style: TextStyles.font14DarkGreyRegular),
        style: TextStyles.font14DarkBlueRegular,
        items: items,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(12),
        dropdownColor: ColorsManager.white,
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: ColorsManager.darkBlue,
        ),
        menuMaxHeight: 210.h,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorsManager.gray),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorsManager.secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ColorsManager.gray),
          ),
        ),
      ),
    );
  }
}
