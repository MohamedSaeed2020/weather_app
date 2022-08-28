import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/core/constants.dart';
import 'package:weather_app/core/network/local/cache_helper.dart';
import 'package:weather_app/core/network/local/storage_keys.dart';
import 'package:weather_app/core/network/remote/dio_helper.dart';
import 'package:weather_app/data_layer/end_points.dart';

class CurrentWeatherWebService{
  Future<dynamic> getCurrentWeatherDataUsingCityName(String city) async {
    try {
      Response response = await DioHelper.getData(
        url: currentWeatherEndPoint,
        query: {
          'appid':apiKey,
          'q':city,
          'units':'metric', //to get the temperature in celsius
        }
      );
      //log('getCurrentWeatherDataUsingCityName web success ${response.data.toString()}');
      return response;
    }  on DioError catch(error) {
      log('getCurrentWeatherDataUsingCityName web error ${error.toString()}');
      return error.response;

    }
  }

  Future<dynamic> getCurrentWeatherDataUsingCoordinates() async {
    try {
      Response response = await DioHelper.getData(
          url: currentWeatherEndPoint,
          query: {
            'appid':apiKey,
            'units':'metric', //to get the temperature in celsius
            'lat':CacheHelper.getData(key: StorageKeys.latitude),
            'lon':CacheHelper.getData(key: StorageKeys.longitude),
          }
      );
      //log('getCurrentWeatherDataUsingCoordinates web success ${response.data.toString()}');
      return response.data;
    }  on DioError catch(error) {
      log('getCurrentWeatherDataUsingCoordinates web error ${error.toString()}');
    }
  }
}