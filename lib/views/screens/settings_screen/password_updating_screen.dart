import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/controllers/password_controller.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/views/global_widgets/button_text_icon.dart';
import 'package:weather_app/views/global_widgets/green_container.dart';
import 'package:weather_app/views/global_widgets/traditional_app_bar.dart';
import 'package:weather_app/views/global_widgets/traditional_text_form_field.dart';
import 'package:weather_app/views/global_widgets/underline_row.dart';

class PasswordUpdatingScreen extends StatefulWidget {
  const PasswordUpdatingScreen({Key? key}) : super(key: key);

  @override
  State<PasswordUpdatingScreen> createState() => _PasswordUpdatingScreenState();
}

class _PasswordUpdatingScreenState extends State<PasswordUpdatingScreen> {
  var formKey = GlobalKey<FormState>();

  final TextEditingController  oldPasswordController = TextEditingController();
  final TextEditingController  newPasswordController = TextEditingController();
  final TextEditingController  confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(8.h),
        child: const TraditionalAppBar(),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.bodyColor,
      body: Column(
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
                          'Password Updating',
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
                    AssetsManager.passwordImage,
                    color: AppColors.blackColor,
                    width: 25.w,
                    height: 25.w,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<PasswordController>(builder: (controller) {
                return Container(
                  margin: EdgeInsets.all(5.w),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TraditionalTextFormField(
                          suffix: controller.suffix,
                          suffixPressed: () {
                            controller.changePasswordVisibility(index: 1);
                          },
                          isPassword: controller.isPassword,
                          hintText: 'Current Password',
                          textInputType: TextInputType.text,
                          controller: oldPasswordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            } else if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TraditionalTextFormField(
                          suffix: controller.suffix,
                          suffixPressed: () {
                            controller.changePasswordVisibility(index: 2);
                          },
                          isPassword: controller.isPassword,
                          hintText: 'New Password',
                          textInputType: TextInputType.text,
                          controller: newPasswordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            } else if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TraditionalTextFormField(
                          suffix: controller.suffix,
                          suffixPressed: () {
                            controller.changePasswordVisibility(index: 3);
                          },
                          isPassword: controller.isPassword,
                          hintText: 'confirm New Password',
                          textInputType: TextInputType.text,
                          controller: confirmNewPasswordController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Required Field';
                            } else if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        CustomMaterialButton(
                          background: AppColors.primaryColor,
                          topLeftRadius: 3.w,
                          topRightRadius: 3.w,
                          bottomLeftRadius: 3.w,
                          bottomRightRadius: 3.w,
                          fontSize: 18.sp,
                          height: 7.h,
                          width: 55.w,
                          pressed: () {
                            if (formKey.currentState!.validate()) {
                              if (newPasswordController.text ==
                                  confirmNewPasswordController.text) {
                                controller.changePassword(
                                  context,
                                  oldPasswordController.text,
                                  newPasswordController.text,
                                );
                                oldPasswordController.clear();
                                newPasswordController.clear();
                                confirmNewPasswordController.clear();
                              } else {
                                UiHelpers.showSnackBar(
                                  "New Passwords Isn't Matching",
                                  'error',
                                );
                              }
                            }
                          },
                          text: 'Confirmation',
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }
}
