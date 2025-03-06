import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';

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
