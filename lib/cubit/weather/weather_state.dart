// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final WeatherStatus status;
  final WeatherModel weatherModel;
  final CustomError error;
  WeatherState({
    required this.status,
    required this.weatherModel,
    required this.error,
  });

  factory WeatherState.initial() {
    return WeatherState(
        status: WeatherStatus.initial,
        weatherModel: WeatherModel.initial(),
        error: CustomError());
  }

  @override
  List<Object?> get props => [status, weatherModel, error];

  @override
  bool get stringify => true;

  WeatherState copyWith({
    WeatherStatus? status,
    WeatherModel? weatherModel,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weatherModel: weatherModel ?? this.weatherModel,
      error: error ?? this.error,
    );
  }
}
