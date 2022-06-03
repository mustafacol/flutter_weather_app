import 'package:flutter/material.dart';
import 'package:weatherapp/cubit/weather/weather_cubit.dart';
import 'package:weatherapp/pages/search_page.dart';
import 'package:weatherapp/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/weather_api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  _fetchWeather() {
    context.read<WeatherCubit>().fetchWeather('london');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SearchPage();
                },
              ));
              print('city: $_city');
              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            },
          )
        ],
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
