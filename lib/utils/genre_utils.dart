import 'package:mvvm_statemanagements/models/movies_genre.dart';

import '../repository/movies_repo.dart';
import '../service/init_getit.dart';

class GenreUtils {
  static List<MoviesGenre> movieGenresNames(List<int> genreIds) {
    final moviesRepository = getIt<MoviesRepository>();
    final cachedGenres = []; //TODO: We need to get the correct cachedGenres
    List<MoviesGenre> genresNames = [];
    for (var genreId in genreIds) {
      var genre = cachedGenres.firstWhere(
        (g) => g.id == genreId,
        orElse: () => MoviesGenre(id: 5448484, name: 'Unknown'),
      );
      genresNames.add(genre);
    }
    return genresNames;
  }
}
