import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import 'app_text_form_field.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final String? selectedDate;
  final Function(String) onDateSelected;
  final DateTime firstDate;
  final DateTime lastDate;

  const DatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.font14DarkBlueBold),
        verticalSpace(8),
        AppTextFormField(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate:
                  selectedDate != null
                      ? DateTime.parse(selectedDate!)
                      : DateTime.now(),
              firstDate: firstDate,
              lastDate: lastDate,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorsManager.primary, // Header background
                      onPrimary: ColorsManager.white, // Header text color
                      onSurface: ColorsManager.darkBlue, // Text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: ColorsManager.primary, // Button color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              onDateSelected(DateFormat('yyyy-MM-dd').format(pickedDate));
            }
          },
          suffixIcon: Icon(Icons.calendar_month_outlined),
          hintText: label,
          readOnly: true,
          controller: TextEditingController(text: selectedDate),
          validator: (value) {},
          onChanged: (value) {},
          keyboardType: TextInputType.datetime,
        ),
      ],
    );
  }
}
