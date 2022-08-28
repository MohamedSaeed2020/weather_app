import 'package:get/instance_manager.dart';
import 'package:weather_app/controllers/email_controller.dart';
import 'package:weather_app/controllers/home_controller.dart';
import 'package:weather_app/controllers/login_controller.dart';
import 'package:weather_app/controllers/nav_bar_controller.dart';
import 'package:weather_app/controllers/next_five_days_forecast_controller.dart';
import 'package:weather_app/controllers/profile_controller.dart';
import 'package:weather_app/controllers/password_controller.dart';
import 'package:weather_app/controllers/sign_up_controller.dart';
import 'package:weather_app/data_layer/repositories/current_weather_repo.dart';
import 'package:weather_app/data_layer/repositories/next_five_days_forecast_repo.dart';
import 'package:weather_app/data_layer/web_services/current_weather_web_service.dart';
import 'package:weather_app/data_layer/web_services/next_five_days_forecast_web_service.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        CurrentWeatherRepo(CurrentWeatherWebService()),
      ),
      fenix: true,
    );
    Get.lazyPut(
      () => NextFiveDaysForecastController(
        NextFiveDaysForecastRepo(
          NextFiveDaysForecastWebService(),
        ),
      ),
      fenix: true,
    );

    Get.lazyPut(
      () => NavigationBarController(),
      fenix: true,
    );
    Get.lazyPut(
      () => LoginController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut(
      () => SignUpController(),
      fenix: true,
    );
    Get.lazyPut(
      () => PasswordController(),
      fenix: true,
    );

    Get.lazyPut(
      () => EmailController(),
      fenix: true,
    );
  }
}
