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
import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drop_down_item.dart';
import 'package:intl/intl.dart';

class ExchangeRatePage extends StatelessWidget {
  const ExchangeRatePage({super.key});

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
      body: UpDownAnimation(
        reverse: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                                ColorsManager
                                                    .primary, // Header background color
                                            onPrimary:
                                                ColorsManager
                                                    .white, // Header text color
                                            onSurface:
                                                ColorsManager
                                                    .darkBlue, // Text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  ColorsManager
                                                      .primary, // Button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
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
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                                ColorsManager
                                                    .primary, // Header background color
                                            onPrimary:
                                                ColorsManager
                                                    .white, // Header text color
                                            onSurface:
                                                ColorsManager
                                                    .darkBlue, // Text color
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  ColorsManager
                                                      .primary, // Button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
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
                _buildPaginationControls(),
              ],
            ),
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
        if (state is ExchangeRateLoading && state is! ExchangeRateLoaded) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ExchangeRateLoaded) {
          return UpDownAnimation(
            reverse: true,
            child: Container(
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
                    state.rates.map((entry) {
                      DateTime date = DateTime.parse(entry.key);
                      return DataRow(
                        cells: [
                          DataCell(
                            Center(
                              child: Text(
                                DateFormat('dd MMMM yyyy').format(date),
                                style: TextStyles.font14DarkBlueBold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                state.base,
                                style: TextStyles.font14DarkBlueBold,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          DataCell(
                            Center(
                              child: Text(
                                state.target,
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

  /// **🔹 Load More Button**
  Widget _buildPaginationControls() {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoaded) {
          final isLastPage = state.isLastPage; // True if there's no more data
          final isFirstPage =
              state.isFirstPage; // True if we're on the first page

          return UpDownAnimation(
            reverse: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color:
                        isFirstPage
                            ? ColorsManager.gray
                            : ColorsManager.secondary,
                  ),
                  onPressed:
                      isFirstPage
                          ? null
                          : () {
                            context.read<ExchangeRateCubit>().fetchRates(
                              loadMore: false, // Go to the previous page
                              isPrevious: true,
                            );
                          },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color:
                        isLastPage
                            ? ColorsManager.gray
                            : ColorsManager.secondary,
                  ),
                  onPressed:
                      isLastPage
                          ? null
                          : () {
                            context.read<ExchangeRateCubit>().fetchRates(
                              loadMore: true, // Load the next page
                            );
                          },
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
