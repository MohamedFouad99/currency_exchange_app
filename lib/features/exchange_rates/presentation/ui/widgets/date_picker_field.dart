import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import 'app_text_form_field.dart';

// date: 7 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a widget that represents a date picker field.
// The widget takes various parameters to customize the appearance and behavior of the date picker field.
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
  /// Builds the UI for a date picker field.
  ///
  /// This widget is responsible for creating a column containing a label and
  /// a [AppTextFormField] widget. The [AppTextFormField] is customized to
  /// show a date picker when tapped. The date picker is configured to
  /// allow the user to pick a date between [firstDate] and [lastDate].
  /// When a date is picked, the [onDateSelected] callback is called with
  /// the selected date as a string in the 'yyyy-MM-dd' format.
  ///
  /// The [AppTextFormField] is also customized to show a calendar icon
  /// in the suffix and to be read-only. The [TextEditingController] is
  /// initialized with the [selectedDate] string, which is displayed in the
  /// text field. The [onChanged] callback is empty, as the text field is
  /// read-only. The [validator] callback is also empty, as the text field
  /// is not validated.
  ///
  /// The [label] parameter is used to display a text label above the
  /// text field.
  ///
  /// The [selectedDate] parameter is used to initialize the
  /// [TextEditingController] with the selected date as a string in the
  /// 'yyyy-MM-dd' format.
  ///
  /// The [onDateSelected] parameter is a callback that is called when a
  /// date is picked. It is passed the selected date as a string in the
  /// 'yyyy-MM-dd' format.
  ///
  /// The [firstDate] parameter is used to configure the date picker to
  /// allow the user to pick a date from this date onwards.
  ///
  /// The [lastDate] parameter is used to configure the date picker to
  /// allow the user to pick a date up to and including this date.
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
