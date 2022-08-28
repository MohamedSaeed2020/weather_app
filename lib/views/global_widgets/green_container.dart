import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/colors.dart';

class GreenDivider extends StatelessWidget {
  const GreenDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1.25.h,
      color: AppColors.lightGreen,
    );
  }
}
