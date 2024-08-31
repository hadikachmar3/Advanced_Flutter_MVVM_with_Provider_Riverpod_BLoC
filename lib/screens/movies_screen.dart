import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/constants/my_theme_data.dart';
import 'package:mvvm_statemanagements/view_models/movies_provider.dart';
import 'package:mvvm_statemanagements/view_models/theme_provider.dart';
import 'package:provider/provider.dart';

import '../constants/my_app_icons.dart';
import '../service/init_getit.dart';
import '../service/navigation_service.dart';
import '../widgets/movies/movies_widget.dart';
import 'favorites_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
        actions: [
          IconButton(
            onPressed: () {
              // getIt<NavigationService>().showSnackbar();
              // getIt<NavigationService>().showDialog(MoviesWidget());
              getIt<NavigationService>().navigate(const FavoritesScreen());
            },
            icon: const Icon(
              MyAppIcons.favoriteRounded,
              color: Colors.red,
            ),
          ),
          Consumer(
            builder: (context, ThemeProvider themeProvider, child) {
              log("Theme Button Rebuild");

              return IconButton(
                onPressed: () async {
                  themeProvider.toggleTheme();
                  // final List<MovieModel> movies = await getIt<ApiService>().fetchMovies();
                  // log("movies $movies");
                  // final List<MoviesGenre> genres =
                  //     await getIt<MoviesRepository>().fetchGenres();
                  // await getIt<ApiService>().fetchGenres();

                  // log("Genres are $genres");
                },
                icon: Icon(
                  themeProvider.themeData == MyThemeData.darkTheme
                      ? MyAppIcons.darkMode
                      : MyAppIcons.lightMode,
                ),
              );
            },
            // child: Text("Theme mode"),
          ),
        ],
      ),
      body: Consumer(builder: (context, MoviesProvider moviesProvider, child) {
        if (moviesProvider.isLoading && moviesProvider.moviesList.isEmpty) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (moviesProvider.fetchMoviesError.isNotEmpty) {
          return Center(child: Text(moviesProvider.fetchMoviesError));
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !moviesProvider.isLoading) {
              moviesProvider.getMovies();
              return true;
            }
            return false;
          },
          child: ListView.builder(
            itemCount: moviesProvider.moviesList.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: moviesProvider.moviesList[index],
                  child: const MoviesWidget());
            },
          ),
        );
      }),
    );
  }
}
