import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_statemanagements/view_models/favorites/favorites_provider.dart';

import '../constants/my_app_icons.dart';
import '../widgets/movies/movies_widget.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoritesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Movies"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoritesProvider.notifier).clearAllFavs();
            },
            icon: const Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: favoriteState.favoritesList.isEmpty
          ? const Center(
              child: Text(
                "No added Favs",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: favoriteState.favoritesList.length,
              itemBuilder: (context, index) {
                return MoviesWidget(
                  movieModel:
                      favoriteState.favoritesList.reversed.toList()[index],
                ); //const Text("data");
              },
            ),
    );
  }
}
