import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/colors.dart';

// ignore: must_be_immutable
class TraditionalTextFormField extends StatelessWidget {
  TraditionalTextFormField({
    Key? key,
    required this.hintText,
    required this.textInputType,
    this.icon,
    required this.controller,
    this.validate,
    this.maxLength,
    this.suffix,
    this.isPassword = false,
    this.suffixPressed,
    this.enabled = true,
  }) : super(key: key);

  final String hintText;
  final int? maxLength;
  final TextInputType textInputType;
  final Widget? icon;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  IconData? suffix;
  bool isPassword = false;
  Function()? suffixPressed;
  bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 14.sp,
      ),
      autofocus: false,
      enabled: enabled,
      maxLength: maxLength,
      validator: validate,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: textInputType,
      obscureText: isPassword,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                icon: Center(
                  child: Icon(
                    suffix,
                    size: 5.w,
                  ),
                ),
                onPressed: suffixPressed,
              )
            : null,
        contentPadding: EdgeInsets.fromLTRB(3.w, 1.h, 3.w, 1.h),
        isDense: true,
        filled: true,
        fillColor: AppColors.whiteColor,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.hintTextColor,
          fontSize: 14.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3.w),
          ),
          borderSide: BorderSide(color: AppColors.greyColor, width: 0.5.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3.w),
          ),
          borderSide: BorderSide(color: AppColors.greyColor, width: 0.5.w),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(3.w),
          ),
          borderSide: BorderSide(color: AppColors.greyColor, width: 0.5.w),
        ),
        icon: icon,
      ),
    );
  }
}
