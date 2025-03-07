import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';
import 'font_weight_helper.dart';

class TextStyles {
  static TextStyle font14DarkBlueRegular = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkBlue,
  );

  static TextStyle font14DarkBlueBold = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font14WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.white,
  );

  static TextStyle font204WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.white,
  );

  static TextStyle font16WhiteBold = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.white,
  );
  static TextStyle font14GreyRegular = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.notActive,
  );
  static TextStyle font14DarkGreyRegular = TextStyle(
    fontFamily: 'Almarai',
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkGray,
  );
}
