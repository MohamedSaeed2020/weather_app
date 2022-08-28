import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/controllers/sign_up_controller.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/helpers/extensions.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/views/global_widgets/custom_button.dart';
import 'package:weather_app/views/global_widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _addressTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bottomGradientColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                5.w, MediaQuery.of(context).size.height * 0.15, 5.w, 0),
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
                  textInputType: TextInputType.name,
                  controller: _userNameTextEditingController,
                  prefixIcon: Icons.person_outline,
                  labelText: 'Enter UserName',
                  isPasswordType: false,
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
                  height: 3.h,
                ),
                CustomTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  controller: _passwordTextEditingController,
                  prefixIcon: Icons.email_outlined,
                  labelText: 'Enter Password',
                  isPasswordType: true,
                ),
                SizedBox(
                  height: 3.h,
                ),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  controller: _addressTextEditingController,
                  prefixIcon: Icons.location_city_outlined,
                  labelText: 'Enter City',
                  isPasswordType: false,
                ),
                SizedBox(
                  height: 3.h,
                ),
                GetBuilder<SignUpController>(builder: (controller) {
                  return CustomButton(
                    text: 'Sign Up',
                    pressed: () {
                      if (_userNameTextEditingController.text.isEmpty) {
                        UiHelpers.showSnackBar(
                            'Please Enter Your Name', 'error');
                      } else {
                        if (!_emailTextEditingController.text
                                .isValidEmail() ||
                            _emailTextEditingController.text.isEmpty) {
                          UiHelpers.showSnackBar(
                              'Please Enter Valid Email', 'error');
                        } else {
                          if (_passwordTextEditingController.text.length <
                              6) {
                            UiHelpers.showSnackBar(
                                'Please Enter Password Of 6 Characters At Least',
                                'error');
                          } else {
                            if (_addressTextEditingController.text.isEmpty) {
                              UiHelpers.showSnackBar(
                                  'Please Enter Your City', 'error');
                            } else {
                              controller.getCurrentLocation(
                                name: _userNameTextEditingController.text,
                                email: _emailTextEditingController.text,
                                password: _passwordTextEditingController.text,
                                city: _addressTextEditingController.text,
                              );
                            }
                          }
                        }
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _addressTextEditingController.dispose();
    super.dispose();
  }
}
