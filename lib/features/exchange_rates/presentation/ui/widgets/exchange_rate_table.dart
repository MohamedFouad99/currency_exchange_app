import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';

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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DataTable(
        headingRowHeight: 40,
        dataRowHeight: 60,
        columnSpacing: 20,
        dataTextStyle: const TextStyle(overflow: TextOverflow.ellipsis),
        horizontalMargin: 1,
        dataRowColor: WidgetStateColor.resolveWith(
          (states) => ColorsManager.white,
        ),
        headingTextStyle: TextStyles.font14WhiteBold,
        headingRowColor: WidgetStateColor.resolveWith(
          (states) => Colors.transparent,
        ),
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
        rows:
            rates.asMap().entries.map((entry) {
              DateTime date = DateTime.parse(entry.value.key);
              int index = entry.key;

              return DataRow(
                color: WidgetStateColor.resolveWith(
                  (states) =>
                      index.isEven ? ColorsManager.white : Colors.grey[200]!,
                ),
                cells: [
                  DataCell(
                    Center(
                      child: Text(
                        DateFormat('MMMM dd, yyyy').format(date),
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        base,
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(
                        target,
                        style: TextStyles.font14DarkBlueBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  DataCell(
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
