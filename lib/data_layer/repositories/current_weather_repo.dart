import 'package:dio/dio.dart';
import 'package:weather_app/data_layer/models/current_weather_model/current_weather_data.dart';
import 'package:weather_app/data_layer/models/current_weather_model/current_weather_error.dart';
import 'package:weather_app/data_layer/web_services/current_weather_web_service.dart';

class CurrentWeatherRepo {
  final CurrentWeatherWebService currentWeatherWebService;

  CurrentWeatherRepo(this.currentWeatherWebService);

  Future<CurrentWeatherData> getCurrentWeatherDataUsingCoordinates() async {
    final currentWeatherData =
    await currentWeatherWebService.getCurrentWeatherDataUsingCoordinates();
    return CurrentWeatherData.fromJson(currentWeatherData);
  }

  Future<Object> getCurrentWeatherDataUsingCityName(String city) async {
    Response currentWeatherData =
    await currentWeatherWebService.getCurrentWeatherDataUsingCityName(city);
    if(currentWeatherData.statusCode==200){
      return CurrentWeatherData.fromJson(currentWeatherData.data);
    }else{
      return CurrentWeatherErrorData.fromJson(currentWeatherData.data);
    }
  }
  }
