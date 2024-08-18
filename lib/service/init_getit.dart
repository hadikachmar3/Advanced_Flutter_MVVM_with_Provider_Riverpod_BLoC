import 'package:get_it/get_it.dart';
import 'package:mvvm_statemanagements/service/navigation_service.dart';

import '../repository/movies_repo.dart';
import 'api_service.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<ApiService>(() => ApiService());
  getIt.registerLazySingleton<MoviesRepository>(
      () => MoviesRepository(getIt<ApiService>()));
}
