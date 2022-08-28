import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';

class PasswordController extends GetxController {
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  int currentIndex = 0;

  void changePasswordVisibility({required int index}) {
    currentIndex = index;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    update();
  }

  void changePassword(
    BuildContext context,
    String oldPassword,
    String newPasswordPassword,
  ) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    AuthCredential authCredentials = EmailAuthProvider.credential(
      email: currentUser!.email!,
      password: oldPassword,
    );

    currentUser.reauthenticateWithCredential(authCredentials).then((value) {
      updateUserPassword(newPasswordPassword).then((user) {
        CacheHelper.saveData(key: StorageKeys.userId, value: user.user!.uid);
        UiHelpers.showSnackBar('Password Changed Successfully', 'success');
      }).catchError((error) {
        log('changePassword Error: ${error.toString()}');
        UiHelpers.showSnackBar('Some Error Has Occurred', 'error');
      });
    }).catchError((error) {
      UiHelpers.showSnackBar('Old Password Not Correct', 'error');
      log('Error in changePassword: ${error.toString()}');
    });
  }

  Future<UserCredential> updateUserPassword(String newPassword) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await currentUser!.updatePassword(newPassword);

    //Reauthenticate With Credential again instead of signing out.
    AuthCredential authCredentials = EmailAuthProvider.credential(
      email: currentUser.email!,
      password: newPassword,
    );
    return  currentUser.reauthenticateWithCredential(authCredentials);
  }
}
