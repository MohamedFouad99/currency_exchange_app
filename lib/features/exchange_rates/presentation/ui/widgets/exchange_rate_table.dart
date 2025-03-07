// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';

// date: 7 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a class that represents a table widget for displaying exchange rates.
class ExchangeRateTable extends StatelessWidget {
  final List<MapEntry<String, double>> rates;
  final String base;
  final String target;

  const ExchangeRateTable({
    super.key,
    required this.rates,
    required this.base,
    required this.target,
  });

  @override
  /// Builds the widget tree for the [ExchangeRateTable].
  ///
  /// This method creates a [DataTable] widget to display the exchange rates.
  /// The table has four columns: 'Date', 'From', 'To', and 'Price'.
  /// Each row in the table represents a single exchange rate, with the date
  /// represented in the format 'MMMM dd, yyyy'.
  /// The 'From' and 'To' columns display the base and target currencies,
  /// respectively. The 'Price' column displays the exchange rate.
  /// The background color of the rows is alternating between white and gray.
  ///
  /// The color of the rows is determined by using the [WidgetStateColor]
  /// class. This class is a helper class that allows you to define a color
  /// based on the state of the widget. In this case, the color is determined
  /// by the index of the row. If the index is even, the color is white;
  /// otherwise, the color is gray.
  ///
  /// The [DataTable] widget is wrapped in a [Container] widget to add
  /// margin and decoration to the table.
  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      // Add margin to the table
      margin: const EdgeInsets.only(top: 8),

      // Set the width of the table to the maximum available width
      width: double.infinity,

      // Set the decoration of the table
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.circular(12),
      ),

      // Create the table
      child: DataTable(
        // Set the height of the heading row
        headingRowHeight: 40,

        // Set the height of the data rows
        dataRowHeight: 60,

        // Set the spacing between the columns
        columnSpacing: 20,

        // Set the text style of the data rows
        dataTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),

        // Set the horizontal margin of the table
        horizontalMargin: 1,

        // Set the color of the data rows
        dataRowColor: WidgetStateColor.resolveWith(
          (states) => ColorsManager.white,
        ),

        // Set the text style of the heading row
        headingTextStyle: TextStyles.font14WhiteBold,

        // Set the color of the heading row
        headingRowColor: WidgetStateColor.resolveWith(
          (states) => Colors.transparent,
        ),

        // Create the columns of the table
        columns: const [
          DataColumn(
            label: Expanded(child: Text('Date', textAlign: TextAlign.center)),
          ),
          DataColumn(
            label: Expanded(child: Text('From', textAlign: TextAlign.center)),
          ),
          DataColumn(
            label: Expanded(child: Text('To', textAlign: TextAlign.center)),
          ),
          DataColumn(
            label: Expanded(child: Text('Price', textAlign: TextAlign.center)),
          ),
        ],

        // Create the rows of the table
        rows:
            rates.asMap().entries.map((entry) {
              DateTime date = DateTime.parse(entry.value.key);
              int index = entry.key;

              // Create a row in the table
              return DataRow(
                // Set the color of the row
                color: WidgetStateColor.resolveWith(
                  (states) =>
                      index.isEven ? ColorsManager.white : Colors.grey[200]!,
                ),

                // Create the cells of the row
                cells: [
                  DataCell(
                    // Create the date cell
                    Center(
                      child: Text(
                        DateFormat('MMMM dd, yyyy').format(date),
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    // Create the base currency cell
                    Center(
                      child: Text(
                        base,
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    // Create the target currency cell
                    Center(
                      child: Text(
                        target,
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    // Create the price cell
                    Center(
                      child: Text(
                        entry.value.value.toStringAsFixed(2),
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
