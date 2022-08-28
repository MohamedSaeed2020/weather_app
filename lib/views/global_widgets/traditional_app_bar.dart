import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/theme/colors.dart';

// ignore: must_be_immutable
class TraditionalAppBar extends StatelessWidget {

  const TraditionalAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
              Get.back();
          },
          icon: SvgPicture.asset(
           AssetsManager.rightArrowImage,
            color: AppColors.whiteColor,
            width: 7.w,
            height: 7.w,
          ),
        ),
      ],
    );
  }
}
