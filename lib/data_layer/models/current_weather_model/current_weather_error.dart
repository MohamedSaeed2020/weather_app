

class CurrentWeatherErrorData {
  String? code;
  String? message;

  CurrentWeatherErrorData.fromJson(dynamic json) {
    code = json['cod']??'';
    message = json['message']??'';
  }
}
