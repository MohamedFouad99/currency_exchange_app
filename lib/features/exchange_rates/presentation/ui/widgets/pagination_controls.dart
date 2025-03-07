import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';

// date: 7 March 2025
// by: Fouad
// last modified at: 7 March 2025
// purpose: Create a class that represents a widget for displaying pagination controls.
class PaginationControls extends StatelessWidget {
  final bool isFirstPage;
  final bool isLastPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PaginationControls({
    super.key,
    required this.isFirstPage,
    required this.isLastPage,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  /// Builds the pagination controls widget.
  ///
  /// This widget displays two [IconButton] widgets for navigating through the
  /// pages of the exchange rate table. The [IconButton] widgets are centered and
  /// have a gray color when the first or last page is reached. The color is
  /// changed to the secondary color when the page is not the first or last.
  ///
  /// The [onPrevious] callback is called when the previous button is pressed and
  /// the [onNext] callback is called when the next button is pressed.
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Previous button
        ///
        /// This button is used to navigate to the previous page.
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: isFirstPage ? ColorsManager.gray : ColorsManager.secondary,
          onPressed: isFirstPage ? null : onPrevious,
        ),
        const SizedBox(width: 20),

        /// Next button
        ///
        /// This button is used to navigate to the next page.
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          color: isLastPage ? ColorsManager.gray : ColorsManager.secondary,
          onPressed: isLastPage ? null : onNext,
        ),
      ],
    );
  }
}
