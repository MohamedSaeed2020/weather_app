import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    required this.isPasswordType,
    required this.textInputType,

  }) : super(key: key);
  final String labelText;
  final IconData prefixIcon;
  final bool isPasswordType;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.white,
      style: TextStyle(color: AppColors.whiteColor.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.white70Color,
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: AppColors.whiteColor.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: AppColors.whiteColor.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.h),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      keyboardType: textInputType,
    );
  }
}
