import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/dependency_injection.dart';
import 'features/exchange_rates/presentation/controllers/exchange_rate_cubit.dart';
import 'features/exchange_rates/presentation/ui/pages/exchange_rate_page.dart';

//date: 6 March 2025
//by: Fouad
//last modified at: 7 March 2025
//purpose: Create a main function that initializes the application.
//The main function initializes the dependencies and runs the application.
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
  ///
  /// The `ScreenUtilInit` widget is used to initialize the screen utils.
  /// It takes the design size of the screen and whether to enable or disable
  /// text adaptation.
  ///
  /// The `BlocProvider` widget is used to provide the `ExchangeRateCubit` to
  /// the `MaterialApp` widget.
  ///
  /// The `MaterialApp` widget is the root of the application, and it
  /// contains the `ExchangeRatePage` as its home screen.
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set the design size of the screen
      designSize: const Size(375, 812),
      // Enable text adaptation
      minTextAdapt: true,
      child: BlocProvider(
        // Create the ExchangeRateCubit
        create: (_) => getIt<ExchangeRateCubit>(),
        // Provide the ExchangeRateCubit to the MaterialApp
        child: MaterialApp(
          // Hide the debug banner
          debugShowCheckedModeBanner: false,
          // Set the home screen to the ExchangeRatePage
          home: ExchangeRatePage(),
        ),
      ),
    );
  }
}
