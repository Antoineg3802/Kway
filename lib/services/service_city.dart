import 'dart:convert';
import 'dart:html';

import 'package:kway/models/city.dart';
import 'package:http/http.dart' as http;

Future<City> getCityData() async {
  var user;
  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=0faf683bd9d00ee0e3ea4fc655e8f9dc');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    user = City.fromJson(jsonResponse);
    print(user);
  } else {
    print('Reponse fail with status methode : ${response.statusCode}');
  }
  return user;
}
