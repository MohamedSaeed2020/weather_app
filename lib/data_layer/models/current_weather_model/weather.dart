class Weather {
  String? description;

  Weather.fromJson(dynamic json) {
    description = json['description']??'';
  }
}
