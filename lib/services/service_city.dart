import 'dart:convert';

import 'package:kway/models/city.dart';
import 'package:http/http.dart' as http;

var isDetectable = true;
//Fonction d'appel à l'api de la météo de paris
Future<City> getCityData(String name) async {
  var city;
  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=0faf683bd9d00ee0e3ea4fc655e8f9dc&units=metric');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    isDetectable = true;
    var jsonResponse = jsonDecode(response.body);
    city = City.fromJson(jsonResponse);
  } else if (response.statusCode == 404) {
    print("Enter an other City because it not exist or we don't found it :/");
    isDetectable = false;
    // var jsonResponse = null;
    // city = City.fromJson(jsonResponse);
  } else {
    print('Reponse fail with status methode : ${response.statusCode}');
  }
  return city;
}
