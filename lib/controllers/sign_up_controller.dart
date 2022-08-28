import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/app_router.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/data_layer/models/user_model.dart';

class SignUpController extends GetxController {
  bool isLoading = false;

  Future<void> getCurrentLocation({
    required String name,
    required String email,
    required String password,
    required String city,
  }) async {
    UiHelpers.getCurrentLocation().then((position) {
      CacheHelper.saveData(key:StorageKeys.latitude, value: position.latitude);
      CacheHelper.saveData(key:StorageKeys.longitude, value: position.longitude);
      registerUser(email: email, password: password,name: name,city: city);
      log('latitude: ${position.latitude}, longitude: ${position.longitude}');
    }).catchError((error){
      UiHelpers.showSnackBar('Permission required to create your account', 'error');
      log('Error in getCurrentLocation: ${error.toString()}');
    });
  }

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String city,
  }) {
    isLoading = true;
    update();
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      if (value.user != null) {
        storeUserData(
          name: name,
          email: email,
          city: city,
          userID: value.user!.uid,
        );
      }
    }).catchError((error) {
      log('Registered user un Successfully: $error');
      isLoading = false;
      update();
    });
  }

  void storeUserData({
    required String name,
    required String email,
    required String city,
    required String userID,
  }) {
    UserModel user = UserModel(
      name: name,
      email: email,
      city: city,
      userId: userID,
    );

    FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .set(user.toMap())
        .then((value) {
      CacheHelper.saveData(key: StorageKeys.userAddress, value: city);
      CacheHelper.saveData(key: StorageKeys.userName, value: name);
      CacheHelper.saveData(key:StorageKeys.userId, value: userID).then((isSaved) {
        if (isSaved == true) {
          log('Registered user Successfully: $userID');
          isLoading = false;
          update();
          UiHelpers.showSnackBar('Your Account has been registered Successfully', 'success');
          Get.offAndToNamed(AppRoutes.navBarRoute);
        }
      });
    }).catchError((error) {
      log('Error in storeUserData: ${error.toString()}');
      isLoading = false;
      update();
    });
  }
}
