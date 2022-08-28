class FiveDayData {
  String? dateTime;
  int? temp;

  FiveDayData.fromJson(dynamic json) {
    String day = json['dt_txt'].split(' ')[0].split('-')[2];
    String hour = json['dt_txt'].split(' ')[1].split(':')[0];
    String dayHour = '$day-$hour';
    dateTime = dayHour;
    temp = (double.parse(json['main']['temp'].toString())).round();
  }
}
