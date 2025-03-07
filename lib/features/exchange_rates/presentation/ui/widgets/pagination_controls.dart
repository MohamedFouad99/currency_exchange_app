import 'package:flutter/material.dart';

import '../../../../../core/theming/colors.dart';

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
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isFirstPage ? ColorsManager.gray : ColorsManager.secondary,
          ),
          onPressed: isFirstPage ? null : onPrevious,
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: isLastPage ? ColorsManager.gray : ColorsManager.secondary,
          ),
          onPressed: isLastPage ? null : onNext,
        ),
      ],
    );
  }
}
