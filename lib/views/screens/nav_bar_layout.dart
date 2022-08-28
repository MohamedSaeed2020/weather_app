import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/nav_bar_controller.dart';
import 'package:weather_app/core/theme/colors.dart';
import 'package:weather_app/core/theme/icon_broken.dart';

class NavigationBarLayout extends StatelessWidget {
  const NavigationBarLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationBarController>(builder: (controller) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColors.transparentColor,
          elevation: 0,
          actions: [
            GetBuilder<NavigationBarController>(builder: (controller) {
              return IconButton(
                icon: const Icon(
                  Icons.logout_outlined,
                  color: AppColors.lightRed,
                ),
                onPressed: () {
                  controller.logOutUser(context);
                },
              );
            }),
          ],
          leading: const SizedBox(),
        ),
        backgroundColor: AppColors.bodyColor,
        body: controller.screens[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.lightGreen,
          unselectedItemColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          onTap: (index) {
            controller.changeIndex(index);
          },
          currentIndex: controller.currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.User), label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting), label: 'Settings'),
          ],
        ),
      );
    });
  }
}
