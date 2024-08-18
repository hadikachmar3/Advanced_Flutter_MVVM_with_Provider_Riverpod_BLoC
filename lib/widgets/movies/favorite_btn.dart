import 'package:flutter/material.dart';

import '../../constants/my_app_icons.dart';

class FavoriteBtnWidget extends StatelessWidget {
  const FavoriteBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: Implement the favorite logic
      },
      icon: Icon(
        MyAppIcons.favoriteOutlineRounded,
        color: null, // isFavorite ? Colors.red : null,
        size: 20,
      ),
    );
  }
}
