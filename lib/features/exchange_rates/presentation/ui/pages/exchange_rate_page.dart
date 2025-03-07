// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../../../../../core/utils/constants.dart';
import '../../controllers/exchange_rate_cubit.dart';
import '../../controllers/exchange_rate_state.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/exchange_rate_table.dart';
import '../widgets/pagination_controls.dart';

// date: 7 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a class that represents the main UI for the exchange rate feature.
class ExchangeRatePage extends StatelessWidget {
  const ExchangeRatePage({super.key});

  @override
  /// Builds the main UI for the Exchange Rate Page.
  ///
  /// This widget is responsible for creating the scaffold, app bar,
  /// and the body containing all necessary components for the exchange rate feature.
  /// It utilizes the [ExchangeRateCubit] to manage state and user interactions.
  Widget build(BuildContext context) {
    // Access the ExchangeRateCubit from the context
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
          // Custom app bar with title
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
                // Date pickers for selecting start and end dates
                _buildDatePickers(cubit),
                verticalSpace(16),
                // Dropdowns for selecting base and target currencies
                _buildCurrencyDropdowns(cubit),
                verticalSpace(16),
                // Button to fetch exchange rates
                _buildFetchButton(context),
                verticalSpace(6),
                // Divider for visual separation
                Divider(color: ColorsManager.gray, thickness: 0.8),
                // Table to display exchange rates
                _buildExchangeRateTable(),
                // Pagination controls for navigating through pages
                _buildPaginationControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Date Picker Row
  ///
  /// This widget builds a row containing two [DatePickerField] widgets.
  /// One is for selecting the start date and the other is for selecting the end date.
  /// It uses the [ExchangeRateCubit] to manage and update the selected dates.
  Widget _buildDatePickers(ExchangeRateCubit cubit) {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: DatePickerField(
                label: "Start Date",
                selectedDate: cubit.startDate,
                onDateSelected:
                    (date) => cubit.setStartDate(
                      date,
                    ), // Updates the start date in the cubit
                firstDate: DateTime.now().subtract(
                  Duration(days: 365),
                ), // Sets the earliest selectable date to one year ago
                lastDate:
                    DateTime.now(), // Sets the latest selectable date to today
              ),
            ),
            horizontalSpace(16), // Adds spacing between the two date pickers
            Expanded(
              child: DatePickerField(
                label: "End Date",
                selectedDate: cubit.endDate,
                onDateSelected:
                    (date) => cubit.setEndDate(
                      date,
                    ), // Updates the end date in the cubit
                firstDate:
                    cubit.startDate != null
                        ? DateTime.parse(
                          cubit.startDate!,
                        ) // Sets the earliest selectable date to the selected start date
                        : DateTime.now().subtract(
                          Duration(days: 365),
                        ), // Defaults to one year ago if no start date is selected
                lastDate:
                    DateTime.now(), // Sets the latest selectable date to today
              ),
            ),
          ],
        );
      },
    );
  }

  /// Currency Dropdown Row
  ///
  /// This widget builds a row containing two [CurrencyDropdown] widgets.
  /// One is for selecting the base currency and the other is for selecting the target currency.
  /// It uses the [ExchangeRateCubit] to manage and update the selected currencies.
  Widget _buildCurrencyDropdowns(ExchangeRateCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: CurrencyDropdown(
            label: "Base Currency",
            selectedValue: cubit.base,
            onChanged:
                (value) => cubit.setBase(value), // Updates the base currency
            items: AppConstants.currencies, // List of available currencies
          ),
        ),
        horizontalSpace(16), // Space between the dropdowns
        Expanded(
          child: CurrencyDropdown(
            label: "Target Currency",
            selectedValue: cubit.target,
            onChanged:
                (value) =>
                    cubit.setTarget(value), // Updates the target currency
            items: AppConstants.currencies, // List of available currencies
          ),
        ),
      ],
    );
  }

  /// Fetch Exchange Rates Button
  Widget _buildFetchButton(BuildContext context) {
    return CustomButton(
      label: "Get Exchange Rates",

      /// When the button is pressed, the [fetchRates] method of the
      /// [ExchangeRateCubit] is called to retrieve the exchange rates.
      onTap: () {
        BlocProvider.of<ExchangeRateCubit>(context).fetchRates();
      },
    );
  }

  ///Exchange Rate Table
  ///
  ///This widget displays the exchange rate table. It displays the table with the
  ///exchange rates, the base currency and the target currency.
  Widget _buildExchangeRateTable() {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExchangeRateLoaded) {
          return ExchangeRateTable(
            ///The exchange rates
            rates: state.rates,

            ///The base currency
            base: state.base,

            ///The target currency
            target: state.target,
          );
        } else if (state is ExchangeRateError) {
          return Center(
            child: Text(
              ///The error message
              state.message,
              style: TextStyles.font14DarkBlueBold.copyWith(color: Colors.red),
            ),
          );
        }
        return Container();
      },
    );
  }

  ///Pagination Controls
  ///
  ///This widget displays the pagination controls for the exchange rate table.
  Widget _buildPaginationControls() {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoaded) {
          return PaginationControls(
            ///Is the first page
            ///
            ///This parameter is used to disable the previous button when the
            ///first page is reached.
            isFirstPage: state.isFirstPage,

            ///Is the last page
            ///
            ///This parameter is used to disable the next button when the last
            ///page is reached.
            isLastPage: state.isLastPage,

            ///Callback for the previous button
            ///
            ///When the previous button is clicked, this callback is called.
            onPrevious: () {
              BlocProvider.of<ExchangeRateCubit>(
                context,
              ).fetchRates(loadMore: false, isPrevious: true);
            },

            ///Callback for the next button
            ///
            ///When the next button is clicked, this callback is called.
            onNext: () {
              BlocProvider.of<ExchangeRateCubit>(
                context,
              ).fetchRates(loadMore: true);
            },
          );
        }
        return Container();
      },
    );
  }
}
