
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/core/constants.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/core/network/remote/dio_helper.dart';
import 'package:weather_app/data_layer/end_points.dart';

class NextFiveDaysForecastWebService{
  Future<List<dynamic>> getNextFiveDaysWeatherDataUsingCoordinates() async {
    try {
      Response response = await DioHelper.getData(
          url: nextFiveDaysWeatherForecastEndPoint,
          query: {
            'appid':apiKey,
            'units':'metric',  //to get the temperature in celsius
            'lat':CacheHelper.getData(key: StorageKeys.latitude),
            'lon':CacheHelper.getData(key: StorageKeys.longitude),
          }
      );
      //log('getNextFiveDaysWeatherDataUsingCoordinates web success ${response.data.toString()}');
      return response.data['list'];
    }  on DioError catch(error) {
      log('getNextFiveDaysWeatherDataUsingCoordinates web error ${error.toString()}');
      return[];
    }
  }
  Future<dynamic> getNextFiveDaysWeatherDataUsingCityName(String city) async {
    try {
      Response response = await DioHelper.getData(
          url: nextFiveDaysWeatherForecastEndPoint,
          query: {
            'appid':apiKey,
            'q':city,
            'units':'metric',  //to get the temperature in celsius
          }
      );
      //log('getNextFiveDaysWeatherDataUsingCityName web success ${response.data.toString()}');
      return response;
    }  on DioError catch(error) {
      log('getNextFiveDaysWeatherDataUsingCityName web error ${error.toString()}');
      return error.response;
    }
  }
}
