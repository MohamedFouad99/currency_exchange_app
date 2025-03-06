import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110.h,
      backgroundColor: ColorsManager.primary,
      title: Text(title, style: TextStyles.font204WhiteBold),
      centerTitle: true,
      leading: null,
    );
  }
}
