import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/theme/colors.dart';

class SettingItem extends StatelessWidget {
  final String leadingIconPath;
  final String title;
  final double titleSize;
  final Function()? onTap;

  const SettingItem({
    Key? key,
    required this.leadingIconPath,
    required this.title,
    this.onTap,
    this.titleSize = 20,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        leadingIconPath,
        color: AppColors.blackColor,
        width: 12.w,
        height: 12.w,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: titleSize, height: 1.2),
      ),
      trailing: SvgPicture.asset(
      AssetsManager.rightArrowImage,
        color: AppColors.greyColor,
        width: 7.w,
        height: 7.w,
      ),
      onTap: onTap,
    );
  }
}
