import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<LoadFavorites>(_loadFavorites);
    on<AddToFavorites>(_addToFavorites);
    on<RemoveFromFavorites>(_removeFromFavorites);
    on<RemoveAllFromFavorites>(_clearAllFavs);
    // _loadFavorites;
  }

  final favskey = "favsKey";
  Future<void> _saveFavorites(List<MovieModel> favoritesList) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList =
        favoritesList.map((movie) => json.encode(movie.toJson())).toList();
    prefs.setStringList(favskey, stringList);
  }

  // bool _isFavorite(MovieModel movieModel) {
  //   if (state is FavoritesLoaded) {
  //     return (state as FavoritesLoaded)
  //         .favorites
  //         .any((movie) => movie.id == movieModel.id);
  //   }
  //   return false;
  // }

  Future<void> _addToFavorites(AddToFavorites event, emit) async {
    // emit(FavoritesError(message: "An error has been occured"));
    // throw Exception("An error has been occured");
    if (state is FavoritesInitial) {
      log('state is FavoritesInitial');
    }
    if (state is FavoritesLoaded) {
      log('state is FavoritesLoaded');
      List<MovieModel> updatedFavorites =
          List.from((state as FavoritesLoaded).favorites)
            ..add(event.movieModel);
      emit(FavoritesLoaded(favorites: updatedFavorites));
      log("updatedFavorites length in the add ${updatedFavorites.length}");
      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _removeFromFavorites(RemoveFromFavorites event, emit) async {
    if (state is FavoritesLoaded) {
      List<MovieModel> updatedFavorites = (state as FavoritesLoaded)
          .favorites
          .where((movie) => movie.id != event.movieModel.id)
          .toList();
      emit(FavoritesLoaded(favorites: updatedFavorites));
      log("updatedFavorites length in the remove ${updatedFavorites.length}");
      await _saveFavorites(updatedFavorites);
    }
  }

  Future<void> _loadFavorites(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favskey) ?? [];
    final favsList = stringList
        .map((movie) => MovieModel.fromJson(json.decode(movie)))
        .toList();
    emit(FavoritesLoaded(favorites: favsList));
  }

  void _clearAllFavs(event, emit) {
    emit(const FavoritesLoaded(favorites: []));
    _saveFavorites([]);
  }
}
