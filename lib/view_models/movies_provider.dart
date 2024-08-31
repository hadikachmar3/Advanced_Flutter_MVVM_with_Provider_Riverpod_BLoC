import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/movies_genre.dart';
import '../models/movies_model.dart';
import '../repository/movies_repo.dart';
import '../service/init_getit.dart';

class MoviesProvider with ChangeNotifier {
  int _currentPage = 1;
  final List<MovieModel> _moviesList = [];
  List<MovieModel> get moviesList => _moviesList;

  List<MoviesGenre> _genresList = [];
  List<MoviesGenre> get genresList => _genresList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _fetchMoviesError = '';
  String get fetchMoviesError => _fetchMoviesError;

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> getMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      if (_genresList.isEmpty) {
        _genresList = await _moviesRepository.fetchGenres();
      }
      List<MovieModel> movies =
          await _moviesRepository.fetchMovies(page: _currentPage);
      _moviesList.addAll(movies);
      _currentPage++;
      _fetchMoviesError = "";
    } catch (error) {
      log("An error occured in fetch movies $error");
      _fetchMoviesError = error.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
