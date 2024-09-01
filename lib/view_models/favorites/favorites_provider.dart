import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/movies_model.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesProvider, FavoritesState>(
  (_) => FavoritesProvider(),
);

class FavoritesProvider extends StateNotifier<FavoritesState> {
  FavoritesProvider() : super(FavoritesState());

  final favskey = "favsKey";

  bool isFavorite(MovieModel movieModel) {
    return state.favoritesList.any((movie) => movie.id == movieModel.id);
  }

  Future<void> addOrRemoveFromFavorites(MovieModel movieModel) async {
    bool wasFavorite = isFavorite(movieModel);
    List<MovieModel> updatedFavorites = wasFavorite
        ? state.favoritesList
            .where(
              (element) => element.id != movieModel.id,
            )
            .toList()
        : [...state.favoritesList, movieModel];

    state = state.copyWith(favoritesList: updatedFavorites);
    // if (isFavorite(movieModel)) {
    //   state.favoritesList.removeWhere((movie) => movie.id == movieModel.id);
    // } else {
    //   state.favoritesList.add(movieModel);
    // }
    await saveFavorites();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = state.favoritesList
        .map((movie) => json.encode(movie.toJson()))
        .toList();
    prefs.setStringList(favskey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favskey) ?? [];
    final movies = stringList
        .map((movie) => MovieModel.fromJson(json.decode(movie)))
        .toList();
    state = state.copyWith(favoritesList: movies);
  }

  void clearAllFavs() {
    state = state.copyWith(favoritesList: []);
    saveFavorites();
  }
}
