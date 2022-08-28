import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/views/screens/home_screen/home_screen.dart';
import 'package:weather_app/views/screens/login_screen.dart';
import 'package:weather_app/views/screens/profile_screen.dart';
import 'package:weather_app/views/screens/settings_screen/settings_screen.dart';

class NavigationBarController extends GetxController {
  bool isLoading = false;
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  void logOutUser(BuildContext context) {
    isLoading = true;
    update();
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: StorageKeys.userId).then((value) {
        CacheHelper.removeData(key: StorageKeys.latitude);
        CacheHelper.removeData(key: StorageKeys.longitude);
        isLoading = false;
        update();
        log('User logged out successfully');
      });
    }).catchError((error) {
      isLoading = false;
      update();
      log('Error in logOutUser: ${error.toString()}');
    }).whenComplete(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    });
  }
}
