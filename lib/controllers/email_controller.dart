import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';

class EmailController extends GetxController {
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

  void updateEmail(BuildContext context, String email, String password) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    AuthCredential authCredentials = EmailAuthProvider.credential(
      email: currentUser!.email!,
      password: password,
    );

    currentUser.reauthenticateWithCredential(authCredentials).then((value) {
      updateUserEmail(email, password).then((user) {
        CacheHelper.saveData(key: StorageKeys.userId, value: user.user!.uid);
        updateFirestoreEmail(email: email);
        UiHelpers.showSnackBar('Email Updated Successfully', 'success');
      }).catchError((error) {
        log('updateEmail Error: ${error.toString()}');
        UiHelpers.showSnackBar('Some Error Has Occurred', 'error');
      });
    }).catchError((error) {
      UiHelpers.showSnackBar('Password Not Correct', 'error');
      log('Error in updateEmail: ${error.toString()}');
    });
  }

  Future<UserCredential> updateUserEmail(String email, String password) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await currentUser!.updateEmail(email);

    //Reauthenticate With Credential again instead of signing out.
    AuthCredential authCredentials = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    return currentUser.reauthenticateWithCredential(authCredentials);
  }

  void updateFirestoreEmail({
    required String email,
  }) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(CacheHelper.getData(key: StorageKeys.userId))
        .update({
          'email': email,
        })
        .then((value) {})
        .catchError((error) {
          log('updateFirestoreEmail Error: ${error.toString()}');
        });
  }
}
