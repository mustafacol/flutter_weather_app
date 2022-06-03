// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weatherapp/exceptions/weather_exception.dart';
import 'package:weatherapp/models/custom_error.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({
    required this.weatherApiServices,
  });

  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final int id = await weatherApiServices.getCityId(city);
      print('CityId: $id');

      final WeatherModel weatherModel = await weatherApiServices.getWeather(id);
      print('Weather: $weatherModel');

      return weatherModel;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
