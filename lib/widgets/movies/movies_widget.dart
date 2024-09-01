import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/constants/my_app_icons.dart';
import 'package:mvvm_statemanagements/screens/movie_details.dart';
import '../../models/movies_model.dart';
import '../../service/init_getit.dart';
import '../../service/navigation_service.dart';
import '../cached_image.dart';
import 'favorite_btn.dart';
import 'genres_list_widget.dart';

class MoviesWidget extends ConsumerWidget {
  const MoviesWidget(
      {super.key,
      // required this.index,
      required this.movieModel});

  final MovieModel movieModel;
  // final int index;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final movieModel = ref.watch(currentMovie(index));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: () {
            getIt<NavigationService>()
                .navigate(MovieDetailsScreen(movieModel: movieModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicWidth(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedImageWidget(
                      imgUrl:
                          "https://image.tmdb.org/t/p/w500/${movieModel.backdropPath}",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieModel.originalTitle,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                                "${movieModel.voteAverage.toStringAsFixed(1)}/10"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        GenresListWidget(
                          movieModel: movieModel,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              MyAppIcons.watchLaterOutlined,
                              size: 20,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              movieModel.releaseDate,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const Spacer(),
                            FavoriteBtnWidget(
                              movieModel: movieModel,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
