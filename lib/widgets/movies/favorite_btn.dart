import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends StatefulWidget {
  const FavoriteBtnWidget({super.key, required this.movieModel});
  final MovieModel movieModel;

  @override
  State<FavoriteBtnWidget> createState() => _FavoriteBtnWidgetState();
}

class _FavoriteBtnWidgetState extends State<FavoriteBtnWidget> {
  final favoriteMovieIds = [];
  @override
  Widget build(BuildContext context) {
    bool isFavorite = favoriteMovieIds.contains(widget.movieModel.id);
    return IconButton(
      onPressed: () {
        if (isFavorite) {
          favoriteMovieIds.remove(widget.movieModel.id);
        } else {
          favoriteMovieIds.add(widget.movieModel.id);
        }
        setState(() {});
      },
      icon: Icon(
        isFavorite ? MyAppIcons.favorite : MyAppIcons.favoriteOutlineRounded,
        color: isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
