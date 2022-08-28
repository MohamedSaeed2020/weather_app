import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/app_router.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/views/global_widgets/green_container.dart';
import 'package:weather_app/views/global_widgets/underline_row.dart';
import 'package:weather_app/views/screens/settings_screen/widgets/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  color: AppColors.primaryColor,
                  height: 22.h,
                ),
                Container(
                  height: 22.h,
                  color: AppColors.bodyColor,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      const GreenDivider(),
                      SizedBox(
                        height: 7.h,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const UnderlineRow(),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.w,
                  color: AppColors.primaryColor,
                ),
              ),
              width: 35.w,
              height: 35.w,
              child: CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: SvgPicture.asset(
                  AssetsManager.settingImage,
                  color: AppColors.blackColor,
                  width: 25.w,
                  height: 25.w,
                ),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border(
              left: BorderSide(
                width: 0.5.w,
                color: AppColors.greyColor,
              ),
              bottom: BorderSide(
                width: 0.5.w,
                color: AppColors.greyColor,
              ),
              top: BorderSide(
                width: 0.5.w,
                color: AppColors.greyColor,
              ),
              right: BorderSide(
                width: 3.w,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          child: Column(
            children: [
              SettingItem(
                leadingIconPath:AssetsManager.passwordImage,
                title: 'Update Password',
                onTap: () {
                  Get.toNamed(AppRoutes.updatePasswordScreen);
                },
              ),
              Divider(
                color: AppColors.greyColor,
                thickness: 0.5.w,
              ),
              SettingItem(
                leadingIconPath:AssetsManager.emailImage,
                title: 'Update Email',
                onTap: () {
                  Get.toNamed(AppRoutes.updateEmailScreen);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
