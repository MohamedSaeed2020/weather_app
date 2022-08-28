import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/controllers/login_controller.dart';
import 'package:weather_app/core/app_router.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/views/global_widgets/custom_button.dart';
import 'package:weather_app/views/global_widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomGradientColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.topGradientColor,
              AppColors.middleGradientColor,
              AppColors.bottomGradientColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  AssetsManager.cloudy,
                  fit: BoxFit.fitWidth,
                  width: 50.w,
                  height: 50.w,
                  //color: Colors.white,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextFormField(
                  textInputType: TextInputType.emailAddress,
                  controller: _emailTextEditingController,
                  prefixIcon: Icons.email_outlined,
                  labelText: 'Enter Email',
                  isPasswordType: false,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  controller: _passwordTextEditingController,
                  prefixIcon: Icons.lock_outline,
                  labelText: 'Enter Password',
                  isPasswordType: true,
                ),
                SizedBox(
                  height: 3.h,
                ),
                GetBuilder<LoginController>(builder: (controller) {
                  return CustomButton(
                    text: 'Sign In',
                    pressed: () {
                      controller
                          .getCurrentLocation(
                            email: _emailTextEditingController.text,
                            password: _passwordTextEditingController.text,
                          );
                    },
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: AppColors.white70Color,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signUpScreen);
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }
}
