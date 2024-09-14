import 'package:mvvm_statemanagements/models/movies_genre.dart';

class GenreUtils {
  static List<MoviesGenre> movieGenresNames(
      List<int> movieGenreIds, List<MoviesGenre> allGenresList) {
    List<MoviesGenre> genresNames = [];
    for (var genreId in movieGenreIds) {
      var genre = allGenresList.firstWhere(
        (g) => g.id == genreId,
        orElse: () => const MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
