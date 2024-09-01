import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/enums/theme_enums.dart';
import 'package:mvvm_statemanagements/screens/splash_screen.dart';

import 'constants/my_theme_data.dart';
import 'logs/riverpod_observer.dart';
import 'service/init_getit.dart';
import 'service/navigation_service.dart';
import 'view_models/theme_provider.dart';

void main() {
  setupLocator(); // Initialize GetIt
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((_) async {
    await dotenv.load(fileName: "assets/.env");
    // https://riverpod.dev/docs/essentials/provider_observer
    runApp(ProviderScope(observers: [
      RiverpodObserver(),
    ], child: const MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    return MaterialApp(
      navigatorKey: getIt<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: themeState == ThemeEnums.dark
          ? MyThemeData.darkTheme
          : MyThemeData.lightTheme,
      home: const SplashScreen(),
      // const SplashScreen(), //const MovieDetailsScreen(), //const FavoritesScreen(), //const MoviesScreen(),
    );
  }
}
