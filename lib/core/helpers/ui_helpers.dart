import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/core/theme/colors.dart';

class UiHelpers {
  static void makeAppInPortraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static showSnackBar(String message, String status) {
    Get.snackbar(
      status == "error" ? 'Problem' : 'Alarm',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          status == "error" ? AppColors.lightRed : AppColors.lightGreen,
      borderRadius: 3.w,
      margin: EdgeInsets.all(8.w),
      colorText: AppColors.whiteColor,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  static Future<Position> getCurrentLocation() async {
    bool isLocationServicesEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!isLocationServicesEnabled) {
      showSnackBar('Enable Location services', 'error');
      return Future.error('Location services are disables');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar('Permission Required', 'error');
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showSnackBar('Permission Required', 'error');

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      //the default accuracy is best
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
