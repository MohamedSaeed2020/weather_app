import 'package:weather_app/data_layer/models/current_weather_model/main_weather.dart';
import 'package:weather_app/data_layer/models/current_weather_model/weather.dart';
import 'package:weather_app/data_layer/models/current_weather_model/wind.dart';

class CurrentWeatherData {
  String? name;
  List<Weather>? weather;
  MainWeather? main;
  Wind? wind;

  CurrentWeatherData.fromJson(dynamic json) {
    name = json['name']??'';
    weather =
        (json['weather'] as List).map((weather) => Weather.fromJson(weather)).toList();
    main = MainWeather.fromJson(json['main']);
    wind = Wind.fromJson(json['wind']);
  }
}
