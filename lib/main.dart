import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/dependency_injection.dart';
import 'features/exchange_rates/presentation/controllers/exchange_rate_cubit.dart';
import 'features/exchange_rates/presentation/pages/exchange_rate_page.dart';

//date: 6 March 2025
//by: Fouad
//last modified at: 6 March 2025
//purpose: Create a main function that initializes the application.
// The main function initializes the dependencies and runs the application.
void main() {
  init(); // Initialize dependencies
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  /// Builds the widget tree for the application, providing the necessary
  /// BlocProvider for state management.
  ///
  /// This method sets up the BlocProvider to manage the state for the
  /// `ExchangeRateCubit`, and returns a `MaterialApp` with the
  /// `ExchangeRatePage` as its home screen.
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExchangeRateCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExchangeRatePage(),
      ),
    );
  }
}
