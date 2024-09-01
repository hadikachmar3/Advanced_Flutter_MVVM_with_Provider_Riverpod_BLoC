import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/my_error_widget.dart';
import 'weather_repo.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initWatch = ref.watch(streamWeatherProvider);
    return Scaffold(
      body: initWatch.when(data: (data) {
        return Center(
          child: Text(
            data,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        );
      }, error: (error, _) {
        return MyErrorWidget(
          errorText: error.toString(),
          retryFunction: () => ref.refresh(streamWeatherProvider),
        );
      }, loading: () {
        return const CircularProgressIndicator.adaptive();
      }),
    );
  }
}
