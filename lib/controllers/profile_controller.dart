import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/data_layer/models/user_model.dart';

class ProfileController extends GetxController {
  bool isEditUserNamePressed = false;
  bool isEditAddressPressed = false;
  var isLoading = false;

  void checkEditProfilePressed(String editType) {
    if (editType == "userName") {
      isEditUserNamePressed = true;
      isEditAddressPressed = false;
      update();
    } else {
      isEditAddressPressed = true;
      isEditUserNamePressed = false;
      update();
    }
  }

  void updateProfile({
    required BuildContext context,
    required String name,
    required String address,
  }) async {
    isLoading = true;
    update();
    UserModel updatedUser = UserModel(
      name: name,
      city: address,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(CacheHelper.getData(key: StorageKeys.userId))
        .update(updatedUser.toMap())
        .then((value) {
      isLoading = false;
      isEditUserNamePressed = false;
      isEditAddressPressed = false;
      CacheHelper.saveData(key: StorageKeys.userAddress, value: address);
      CacheHelper.saveData(key: StorageKeys.userName, value: name);
      UiHelpers.showSnackBar('Update profile Successfully', 'success');
      update();
    }).catchError((error) {
      log('Update Profile Error: ${error.toString()}');
      isLoading = false;
      update();
      UiHelpers.showSnackBar(
          'An error occurred while updating the profile', 'error');
    });
  }
}
