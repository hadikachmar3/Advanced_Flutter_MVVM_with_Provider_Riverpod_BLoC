import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvvm_statemanagements/constants/api_constants.dart';
import 'package:mvvm_statemanagements/models/movies_genre.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

class ApiService {
  Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    final url = Uri.parse(
        "${ApiConstants.baseUrl}/movie/popular?language=en-US&page=$page");
    final response = await http
        .get(url, headers: ApiConstants.headers)
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log("data $data");
      return List.from(
          data['results'].map((element) => MovieModel.fromJson(element)));
    } else {
      throw Exception("Failed to load movies: ${response.statusCode}");
    }
  }

  Future<List<MoviesGenre>> fetchGenres() async {
    final url =
        Uri.parse("${ApiConstants.baseUrl}/genre/movie/list?language=en");
    final response = await http
        .get(url, headers: ApiConstants.headers)
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // log("data $data");
      return List.from(
          data['genres'].map((element) => MoviesGenre.fromJson(element)));
    } else {
      throw Exception("Failed to load movies: ${response.statusCode}");
    }
  }
}
