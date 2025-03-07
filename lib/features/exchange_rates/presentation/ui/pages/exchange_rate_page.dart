// ignore_for_file: deprecated_member_use

import 'package:currency_exchange_app/core/helpers/spacing.dart';
import 'package:currency_exchange_app/core/utils/constants.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/controllers/exchange_rate_cubit.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/controllers/exchange_rate_state.dart';
import 'package:currency_exchange_app/features/exchange_rates/presentation/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/animations/up_down_animation.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/date_picker_field.dart';

import '../widgets/exchange_rate_table.dart';
import '../widgets/pagination_controls.dart';

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
                _buildDatePickers(cubit),
                verticalSpace(16),
                _buildCurrencyDropdowns(cubit),
                verticalSpace(20),
                _buildFetchButton(context),
                verticalSpace(6),
                Divider(color: ColorsManager.gray, thickness: 0.8),
                _buildExchangeRateTable(),
                _buildPaginationControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Date Picker Row
  Widget _buildDatePickers(ExchangeRateCubit cubit) {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: DatePickerField(
                label: "Start Date",
                selectedDate: cubit.startDate,
                onDateSelected: (date) => cubit.setStartDate(date),
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now(),
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: DatePickerField(
                label: "End Date",
                selectedDate: cubit.endDate,
                onDateSelected: (date) => cubit.setEndDate(date),
                firstDate:
                    cubit.startDate != null
                        ? DateTime.parse(cubit.startDate!)
                        : DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now(),
              ),
            ),
          ],
        );
      },
    );
  }

  ///Currency Dropdown Row
  Widget _buildCurrencyDropdowns(ExchangeRateCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: CurrencyDropdown(
            label: "Base Currency",
            selectedValue: cubit.base,
            onChanged: (value) => cubit.setBase(value),
            items: AppConstants.currencies,
          ),
        ),
        horizontalSpace(16),
        Expanded(
          child: CurrencyDropdown(
            label: "Target Currency",
            selectedValue: cubit.target,
            onChanged: (value) => cubit.setTarget(value),
            items: AppConstants.currencies,
          ),
        ),
      ],
    );
  }

  ///Fetch Exchange Rates Button
  Widget _buildFetchButton(context) {
    return CustomButton(
      label: "Get Exchange Rates",
      onTap: () {
        BlocProvider.of<ExchangeRateCubit>(context).fetchRates();
      },
    );
  }

  ///Exchange Rate Table
  Widget _buildExchangeRateTable() {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExchangeRateLoaded) {
          return ExchangeRateTable(
            rates: state.rates,
            base: state.base,
            target: state.target,
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

  ///Pagination Controls
  Widget _buildPaginationControls() {
    return BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
      builder: (context, state) {
        if (state is ExchangeRateLoaded) {
          return PaginationControls(
            isFirstPage: state.isFirstPage,
            isLastPage: state.isLastPage,
            onPrevious: () {
              BlocProvider.of<ExchangeRateCubit>(
                context,
              ).fetchRates(loadMore: false, isPrevious: true);
            },
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
