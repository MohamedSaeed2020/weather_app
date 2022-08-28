class MainWeather {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  MainWeather.fromJson(dynamic json) {
    temp = json['temp'] ?? 0.0;
    feelsLike = json['feels_like'] ?? 0.0;
    tempMin = json['temp_min'] ?? 0.0;
    tempMax = json['temp_max'] ?? 0;
    pressure = json['pressure'] ?? 0;
  }
}
