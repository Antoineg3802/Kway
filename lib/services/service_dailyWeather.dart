import 'dart:convert';

import 'package:kway/models/dailyWeather.dart';
import 'package:http/http.dart' as http;

Future<List<Daily>> getDailyWeather(double? lon, double? lat) async {

  List<Daily> dailyWeatherList= [];

  var url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=0faf683bd9d00ee0e3ea4fc655e8f9dc&units=metric'
  );
  var response = await http.get(url);
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    var dailyWeather = DailyWeather.fromJson(jsonResponse);
    for(var i = 1; i < 8 ; i++) {
      dailyWeatherList.add(dailyWeather.daily![i]);
    }

  } else if (response.statusCode == 404) {
  } else {
    print('Reponse fail with status methode : ${response.statusCode}');
  }
  return dailyWeatherList;
}