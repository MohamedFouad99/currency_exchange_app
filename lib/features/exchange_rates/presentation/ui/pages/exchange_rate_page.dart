// ignore_for_file: deprecated_member_use

import 'package:currency_exchange_app/core/helpers/spacing.dart';
import 'package:currency_exchange_app/core/utils/constants.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/controllers/exchange_rate_cubit.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/controllers/exchange_rate_state.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/ui/widgets/app_text_form_field.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drop_down_item.dart';

class ExchangeRatePage extends StatefulWidget {
  @override
  _ExchangeRatePageState createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  int _currentPage = 0;
  static const int _rowsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExchangeRateCubit>();
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: CustomAppBar(title: "Exchange Rates"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  verticalSpace(16),
              BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start Date',
                              style: TextStyles.font14DarkBlueBold,
                            ),
                            verticalSpace(8),
                            AppTextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      cubit.startDate != null
                                          ? DateTime.parse(cubit.startDate!)
                                          : DateTime.now(),
                                  firstDate: DateTime.now().subtract(
                                    Duration(days: 365),
                                  ),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  cubit.setStartDate(
                                    pickedDate.toString().split(" ")[0],
                                  );
                                }
                              },
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              hintText: 'Start Date',
                              readOnly: true,
                              controller: TextEditingController(
                                text: cubit.startDate,
                              ),
                              validator: (value) {},
                              onChanged: (value) {},
                              keyboardType: TextInputType.datetime,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'End Date',
                              style: TextStyles.font14DarkBlueBold,
                            ),
                            verticalSpace(8),
                            AppTextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      cubit.endDate != null
                                          ? DateTime.parse(cubit.endDate!)
                                          : DateTime.now(),
                                  firstDate:
                                      cubit.startDate != null
                                          ? DateTime.parse(cubit.startDate!)
                                          : DateTime.now().subtract(
                                            Duration(days: 365),
                                          ),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  cubit.setEndDate(
                                    pickedDate.toString().split(" ")[0],
                                  );
                                }
                              },
                              suffixIcon: Icon(Icons.calendar_month_outlined),
                              hintText: 'End Date',
                              controller: TextEditingController(
                                text: cubit.endDate,
                              ),
                              readOnly: true,
                              validator: (value) {},
                              onChanged: (value) {},
                              keyboardType: TextInputType.datetime,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              verticalSpace(16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Base Currency',
                          style: TextStyles.font14DarkBlueBold,
                        ),
                        verticalSpace(8),
                        DropDownItem(
                          onChanged: (value) {
                            cubit.setBase(value!);
                          },
                          items:
                              AppConstants.currencies.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                          text: 'Base Currency',
                          value: cubit.base,
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Target Currency',
                          style: TextStyles.font14DarkBlueBold,
                        ),
                        verticalSpace(8),
                        DropDownItem(
                          onChanged: (value) {
                            cubit.setTarget(value!);
                          },
                          items:
                              AppConstants.currencies.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                          text: 'Target Currency',
                          value: cubit.target,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              verticalSpace(20),
              CustomButton(
                label: "Get Exchange Rates",
                onTap: () {
                  context.read<ExchangeRateCubit>().fetchRates();
                },
              ),
              verticalSpace(6),
              Divider(color: ColorsManager.gray, thickness: .8),
              _buildExchangeRateTable(),
            ],
          ),
        ),
      ),
    );
  }

  /////////////////////////////////////////////////////////
  /// **🔹 Exchange Rate Table with Pagination**
  Widget _buildExchangeRateTable() {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExchangeRateLoaded) {
          final exchangeRates = state.exchangeRate.rates.entries.toList();
          return Container(
            margin: EdgeInsets.only(top: 8.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DataTable(
              headingRowHeight: 40.h,
              dataRowHeight: 60.h,
              columnSpacing: 20.w,
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
                  label: Expanded(
                    child: Text('Date', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('From', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('To', textAlign: TextAlign.center),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Price', textAlign: TextAlign.center),
                  ),
                ),
              ],
              rows:
                  exchangeRates.map((entry) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Center(
                            child: Text(
                              entry.key,
                              style: TextStyles.font14DarkBlueBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              state.exchangeRate.base,
                              style: TextStyles.font14DarkBlueBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              state.exchangeRate.target,
                              style: TextStyles.font14DarkBlueBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Text(
                              entry.value.toStringAsFixed(2),
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
        } else if (state is ExchangeRateError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyles.font14DarkBlueBold.copyWith(color: Colors.red),
            ),
          );
        }
        return Container();
      },
    );
  }

  /////////////////////////////////////////////////////////////////
  ///  Pagination Controls**
  // Widget _buildPaginationControls(int totalPages) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Text("Page ${_currentPage + 1} of $totalPages"),
  //       Row(
  //         children: [
  //           IconButton(
  //             icon: Icon(Icons.arrow_back),
  //             onPressed:
  //                 _currentPage > 0
  //                     ? () => setState(() => _currentPage--)
  //                     : null,
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.arrow_forward),
  //             onPressed:
  //                 _currentPage < totalPages - 1
  //                     ? () => setState(() => _currentPage++)
  //                     : null,
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
