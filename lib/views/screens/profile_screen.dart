import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app/controllers/profile_controller.dart';
import 'package:weather_app/core/helpers/assets_paths.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/views/global_widgets/button_text_icon.dart';
import 'package:weather_app/views/global_widgets/green_container.dart';
import 'package:weather_app/views/global_widgets/traditional_text_form_field.dart';
import 'package:weather_app/views/global_widgets/underline_row.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _addressTextEditingController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userNameTextEditingController.text =
        CacheHelper.getData(key: StorageKeys.userName);
    _addressTextEditingController.text =
        CacheHelper.getData(key: StorageKeys.userAddress);
    super.initState();
  }

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
                     GetBuilder<ProfileController>(builder: (controller){
                       return  Text(
                         CacheHelper.getData(key: StorageKeys.userName),
                         style: TextStyle(
                           fontSize: 22.sp,
                           fontWeight: FontWeight.bold,
                         ),
                       );
                     }),
                      SizedBox(
                        height: 1.h,
                      ),
                      const UnderlineRow(),
                    ],
                  ),
                ),
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
                  AssetsManager.profileImage,
                  color: AppColors.primaryColor,
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
            child: GetBuilder<ProfileController>(builder: (controller) {
              return Container(
                padding: EdgeInsets.all(5.w),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 25.w,
                            child: Text(
                              'User Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: TraditionalTextFormField(
                              enabled: controller.isEditUserNamePressed
                                  ? true
                                  : false,
                              hintText: 'User Name',
                              textInputType: TextInputType.name,
                              controller: _userNameTextEditingController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Required Field';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.checkEditProfilePressed('userName');
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 7.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25.w,
                            child: Text(
                              'Address',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: TraditionalTextFormField(
                              enabled: controller.isEditAddressPressed
                                  ? true
                                  : false,
                              hintText: 'Address',
                              textInputType: TextInputType.name,
                              controller: _addressTextEditingController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Required Field';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.checkEditProfilePressed('address');
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 7.w,
                            ),
                          ),
                        ],
                      ),
                      if (controller.isEditUserNamePressed ||
                          controller.isEditAddressPressed)
                        SizedBox(
                          height: 5.h,
                        ),
                      (controller.isEditUserNamePressed ||
                              controller.isEditAddressPressed)
                          ? controller.isLoading == false
                              ? CustomMaterialButton(
                                  background: AppColors.lightGreen,
                                  topLeftRadius: 3.w,
                                  topRightRadius: 3.w,
                                  bottomLeftRadius: 3.w,
                                  bottomRightRadius: 3.w,
                                  fontSize: 18.sp,
                                  height: 7.h,
                                  width: 55.w,
                                  pressed: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.updateProfile(
                                        context: context,
                                        name:
                                            _userNameTextEditingController.text,
                                        address:
                                            _addressTextEditingController.text,
                                      );
                                    }
                                  },
                                  text: 'Update Profile',
                                )
                              : const CircularProgressIndicator()
                          : const SizedBox(),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _userNameTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _addressTextEditingController.dispose();
    super.dispose();
  }
}
