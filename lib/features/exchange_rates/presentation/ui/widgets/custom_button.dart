import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isAvailable;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.height,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height ?? 50.h,
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (isAvailable ? ColorsManager.primary : ColorsManager.notActive),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyles.font16WhiteBold.copyWith(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
