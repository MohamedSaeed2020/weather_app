import 'package:dio/dio.dart';
import 'package:weather_app/data_layer/models/next_five_days_forecast_model/five_days_data.dart';
import 'package:weather_app/data_layer/web_services/next_five_days_forecast_web_service.dart';

class NextFiveDaysForecastRepo {
  final NextFiveDaysForecastWebService nextFiveDaysForecastWebService;

  NextFiveDaysForecastRepo(this.nextFiveDaysForecastWebService);

  Future<List<FiveDayData>> getNextFiveDaysWeatherDataUsingCoordinates() async {
    final nextFiveDaysForecastData = await nextFiveDaysForecastWebService
        .getNextFiveDaysWeatherDataUsingCoordinates();
    if (nextFiveDaysForecastData != []) {
      return nextFiveDaysForecastData
          .map((nextFiveDaysForecastData) =>
              FiveDayData.fromJson(nextFiveDaysForecastData))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<FiveDayData>> getNextFiveDaysWeatherDataUsingCityName(
      String cityName) async {
    Response nextFiveDaysForecastData = await nextFiveDaysForecastWebService
        .getNextFiveDaysWeatherDataUsingCityName(cityName);
    if (nextFiveDaysForecastData.statusCode==200) {
      return (nextFiveDaysForecastData.data['list'])
          .map((nextFiveDaysForecastData) =>
              FiveDayData.fromJson(nextFiveDaysForecastData))
          .toList();
    } else {
      return [];
    }
  }
}
