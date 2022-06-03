// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/constants/constants.dart';
import 'package:weatherapp/exceptions/weather_exception.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({
    required this.httpClient,
  });

  Future<int> getCityId(String city) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: host,
        path: '/data/2.5/weather',
        queryParameters: {'q': city, 'appid': apiKey});
    try {
      final http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the id of the $city');
      }

      return responseBody['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherModel> getWeather(int cityId) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: host,
        path: '/data/2.5/weather',
        queryParameters: {'id': cityId, 'appid': apiKey}.map((key, value) => MapEntry(key, value.toString())));

    try {
      final http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);

      final WeatherModel weatherModel = WeatherModel.fromJson(weatherJson);

      print(weatherModel);

      return weatherModel;
    } catch (e) {
      rethrow;
    }
  }
}
