import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/controllers/bindings.dart';
import 'package:weather_app/core/app_router.dart';
import 'package:weather_app/core/constants.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';

class ApplicationMainWidget extends StatelessWidget {
  const ApplicationMainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: child!,
          );
        },
        theme: ThemeData(
          fontFamily: fontFamily,
        ),
        initialBinding: Binding(),
        initialRoute: CacheHelper.getData(key: StorageKeys.userId) != null
            ? AppRoutes.navBarRoute
            : AppRoutes.initialRoute,
        getPages: AppRoutes.routes,
      );
    });
  }
}
