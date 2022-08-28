import 'package:get/get.dart';
import 'package:weather_app/views/screens/home_screen/home_screen.dart';
import 'package:weather_app/views/screens/login_screen.dart';
import 'package:weather_app/views/screens/nav_bar_layout.dart';
import 'package:weather_app/views/screens/profile_screen.dart';
import 'package:weather_app/views/screens/settings_screen/email_updating_screen.dart';
import 'package:weather_app/views/screens/settings_screen/password_updating_screen.dart';
import 'package:weather_app/views/screens/settings_screen/settings_screen.dart';
import 'package:weather_app/views/screens/sign_up_screen.dart';
import 'package:weather_app/views/screens/splash_screen.dart';

class AppRoutes {
  static String initialRoute = "/splash-screen";
  static String signUpScreen = "/signUp-screen";
  static String loginScreen = "/login-screen";
  static String navBarRoute = "/nav-bar-screen";
  static String homeScreen = "/home-screen";
  static String profileScreen = "/profile-screen";
  static String settingScreen = "/setting-screen";
  static String updateEmailScreen = "/email-update-screen";
  static String updatePasswordScreen = "/update-password-screen";

  static List<GetPage> routes = [
    GetPage(name: initialRoute, page: () => const SplashScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: navBarRoute, page: () => const NavigationBarLayout()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
    GetPage(name: updateEmailScreen, page: () => const EmailUpdatingScreen()),
    GetPage(
        name: updatePasswordScreen, page: () => const PasswordUpdatingScreen()),
  ];
}
