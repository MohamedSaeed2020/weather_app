import 'dart:developer';

import 'package:get/get.dart';
import 'package:weather_app/core/helpers/ui_helpers.dart';
import 'package:weather_app/data_layer/models/next_five_days_forecast_model/five_days_data.dart';
import 'package:weather_app/data_layer/repositories/next_five_days_forecast_repo.dart';

class NextFiveDaysForecastController extends GetxController{

  final NextFiveDaysForecastRepo nextFiveDaysForecastRepo;
  NextFiveDaysForecastController(this.nextFiveDaysForecastRepo);
  bool nextFiveDaysForecastIsLoading = false;
  List<FiveDayData> fiveDaysData = [];


  @override
  Future<void> onInit() async {
    getNextFiveDaysWeatherDataUsingCoordinates();
    super.onInit();
  }

  void getNextFiveDaysWeatherDataUsingCoordinates() {
    nextFiveDaysForecastIsLoading=true;
    update();
    nextFiveDaysForecastRepo.getNextFiveDaysWeatherDataUsingCoordinates().then((nextFiveDaysForecastData) {
      nextFiveDaysForecastIsLoading=false;
      fiveDaysData = nextFiveDaysForecastData;
      update();
      log('Successfully loaded  getNextFiveDaysWeatherDataUsingCoordinates: ${fiveDaysData[0].dateTime}');
    }).catchError((error) {
      nextFiveDaysForecastIsLoading=false;
      update();
      log('Error in getNextFiveDaysWeatherDataUsingCoordinates: ${error.toString()}');
    });
  }
  void getNextFiveDaysWeatherDataUsingCityName(String cityName) {
    nextFiveDaysForecastIsLoading=true;
    update();
    nextFiveDaysForecastRepo.getNextFiveDaysWeatherDataUsingCityName(cityName).then((nextFiveDaysForecastData) {
      nextFiveDaysForecastIsLoading=false;
      update();
      if(nextFiveDaysForecastData.isNotEmpty){
        fiveDaysData = nextFiveDaysForecastData;
        log('Successfully loaded  getNextFiveDaysWeatherDataUsingCityName: ${fiveDaysData[0].dateTime}');
      }else{
        UiHelpers.showSnackBar('No weather chart available for this city', 'error');
      }
    }).catchError((error) {
      nextFiveDaysForecastIsLoading=false;
      update();
      log('Error in getNextFiveDaysWeatherDataUsingCityName: ${error.toString()}');
    });
  }
}