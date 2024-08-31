import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});
  final MovieModel movieModel;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, FavoritesProvider favoritesProvider, _) {
      return IconButton(
        onPressed: () {
          favoritesProvider.addOrRemoveFromFavorites(movieModel);
        },
        icon: Icon(
          favoritesProvider.isFavorite(movieModel)
              ? MyAppIcons.favoriteRounded
              : MyAppIcons.favoriteOutlineRounded,
          color: favoritesProvider.isFavorite(movieModel) ? Colors.red : null,
          size: 20,
        ),
      );
    });
  }
}
