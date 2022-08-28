import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:weather_app/controllers/next_five_days_forecast_controller.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/data_layer/models/current_weather_model/current_weather_data.dart';
import 'package:weather_app/data_layer/models/current_weather_model/current_weather_error.dart';
import 'package:weather_app/data_layer/repositories/current_weather_repo.dart';

class HomeController extends GetxController {
  final CurrentWeatherRepo currentWeatherRepo;

  HomeController(this.currentWeatherRepo);

  ///variables
  bool isLoading = false;
  CurrentWeatherData? currentWeatherData;
  final List<String> cities = [
    'zagazig',
    'cairo',
    'alexandria',
    'ismailia',
    'fayoum'
  ];
  bool topFiveCitiesIsLoading = false;
  List<CurrentWeatherData> topFiveCitiesForecast = [];

  @override
  Future<void> onInit() async {
    getCurrentWeatherDataUsingCoordinates();
    getTopFiveCities();
    super.onInit();
  }

  void updateWeather(String city) {
    getCurrentWeatherDataUsingCityName(city);
    Get.find<NextFiveDaysForecastController>().getNextFiveDaysWeatherDataUsingCityName(city);
    }
  void getCurrentWeatherDataUsingCoordinates() {
    isLoading = true;
    update();
    currentWeatherRepo.getCurrentWeatherDataUsingCoordinates().then((data) {
      isLoading = false;
      currentWeatherData = data;
      update();
      log('Successfully loaded  getCurrentWeather: ${currentWeatherData!.name}');
    }).catchError((error) {
      isLoading = false;
      update();
      log('Error in getCurrentWeather: ${error.toString()}');
    });
  }
  void getCurrentWeatherDataUsingCityName(String city) {
    isLoading = true;
    update();
    currentWeatherRepo.getCurrentWeatherDataUsingCityName(city).then((data) {
      isLoading = false;
      update();
      if(data.runtimeType==CurrentWeatherData){
        currentWeatherData = data as CurrentWeatherData;
        log('Successfully loaded  getCurrentWeatherDataUsingCityName: ${currentWeatherData!.name}');
      }else{
        UiHelpers.showSnackBar('City not found', 'error');
        log('City not found: ${(data as CurrentWeatherErrorData).message}');
      }

    }).catchError((error) {
      isLoading = false;
      update();
      log('Error in getCurrentWeatherDataUsingCityName: ${error.toString()}');
    });
  }
  void getTopFiveCities() {
    topFiveCitiesIsLoading = true;
    topFiveCitiesForecast.clear();
    for (var city in cities) {
      currentWeatherRepo
          .getCurrentWeatherDataUsingCityName(city)
          .then(( currentCityWeatherData) {
        topFiveCitiesIsLoading = false;
        topFiveCitiesForecast.add(currentCityWeatherData as CurrentWeatherData);
        update();
        log('Successfully loaded  getTopFiveCities: ${currentCityWeatherData.name}');
      }).catchError((error) {
        topFiveCitiesIsLoading = false;
        update();
        log('Error in getTopFiveCities: ${error.toString()}');
      });
    }
  }
}
