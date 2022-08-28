import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/remote/dio_helper.dart';
import 'package:weather_app/views/global_widgets/app_material_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();
  UiHelpers.makeAppInPortraitModeOnly();
  runApp(const ApplicationMainWidget());
}



