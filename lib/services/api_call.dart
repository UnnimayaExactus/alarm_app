import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sample/constants/api_key.dart';

import '../data_models/weather_model.dart';

Future getCurrentWeather(city) async {
  Weather weather;

  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));
  print('=======$url');

  if (response.statusCode == 200) {
    print('========${jsonDecode(response.body)}');
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {
    weather = Weather();
    // TODO: Throw error here
  }

  return weather;
}
