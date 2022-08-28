import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:weather_app/core/app_router.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/data_layer/models/user_model.dart';

class LoginController extends GetxController {
  bool isLoading = false;


  Future<void> getCurrentLocation({required String email, required String password}) async {
    UiHelpers.getCurrentLocation().then((position) {
      CacheHelper.saveData(key:StorageKeys.latitude, value: position.latitude);
      CacheHelper.saveData(key:StorageKeys.longitude, value: position.longitude);
      loginUser(email: email, password: password);
      log('latitude: ${position.latitude}, longitude: ${position.longitude}');
    }).catchError((error){
      UiHelpers.showSnackBar('Permission required to login', 'error');
      log('Error in getCurrentLocation: ${error.toString()}');
    }).whenComplete(() {
      log('getCurrentLocation Successfully');
    });
  }

  void loginUser({required String email, required String password}) {
    isLoading = true;
    update();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      if (value.user != null) {
        getUserInfo(value.user!);
        CacheHelper.saveData(key: StorageKeys.userId, value: value.user!.uid);
        UiHelpers.showSnackBar('Logged In Successfully', 'success');
        log('Logged User Successfully: ${value.user!.uid}');
        isLoading = false;
        update();
        Get.offAndToNamed(AppRoutes.navBarRoute);
      }
    }).catchError((error) {
      UiHelpers.showSnackBar('Please enter valid email and password', 'error');
      log('Logged User Un Successfully: $error}');
      isLoading = false;
      update();
    });
  }

  void getUserInfo(User user) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        UserModel user = UserModel.fromJson(value.data());
        CacheHelper.saveData(key: StorageKeys.userAddress, value: user.city);
        CacheHelper.saveData(key: StorageKeys.userName, value: user.name);
      }
    }).catchError((error) {
      log('Error in getUserInfo: ${error.toString()}');
    });
  }
}
