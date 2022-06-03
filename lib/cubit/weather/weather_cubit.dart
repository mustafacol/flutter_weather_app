// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:weatherapp/models/custom_error.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({
    required this.weatherRepository,
  }) : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final WeatherModel weatherModel =
          await weatherRepository.fetchWeather(city);

      emit(state.copyWith(
          status: WeatherStatus.loaded, weatherModel: weatherModel));
    } on CustomError catch (e) {
      emit(state.copyWith(
        error: e,
        status: WeatherStatus.error,
      ));
    }
  }
}
