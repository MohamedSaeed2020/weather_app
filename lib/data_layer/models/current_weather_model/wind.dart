class Wind {
  double? speed;

  Wind.fromJson(dynamic json) {
    speed = json['speed'] ?? 0.0;
  }
}
