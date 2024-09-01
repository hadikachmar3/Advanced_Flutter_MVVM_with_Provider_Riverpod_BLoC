import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';

import '../../constants/my_app_icons.dart';
import '../../models/movies_model.dart';

class FavoriteBtnWidget extends ConsumerWidget {
  const FavoriteBtnWidget({
    super.key,
    required this.movieModel,
  });
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dont do this!!
    // final favoritesState = ref.read(favoritesProvider);
    // Do this instead!
    final favoritesList =
        ref.watch(favoritesProvider.select((state) => state.favoritesList));
    final isFavorite = favoritesList.any((movie) => movie.id == movieModel.id);
    return IconButton(
      onPressed: () {
        ref
            .read(favoritesProvider.notifier)
            .addOrRemoveFromFavorites(movieModel);
      },
      icon: Icon(
        isFavorite
            ? MyAppIcons.favoriteRounded
            : MyAppIcons.favoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
