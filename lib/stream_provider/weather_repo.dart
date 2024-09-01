import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamWeatherProvider = StreamProvider.autoDispose<String>((ref) async* {
  // ref.keepAlive();
  while (true) {
    final weather = await WeatherRepo.fetchWeather();
    yield weather;
  }
});

class WeatherRepo {
  static final Random _random = Random();

  static Future<String> fetchWeather() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    final weatherStates = ["Sunny", "Rainy", "Cloudy", "Snowy", "Windy"];
    final temperature =
        15 + _random.nextInt(15); // Random temperature from 15 to 29
    final weather = weatherStates[_random.nextInt(weatherStates.length)];
    return "$weather, ${temperature}c";
  }
}
