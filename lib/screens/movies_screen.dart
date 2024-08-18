
import 'package:flutter/material.dart';
import 'package:mvvm_statemanagements/models/movies_model.dart';
import 'package:mvvm_statemanagements/screens/favorites_screen.dart';

import '../constants/my_app_icons.dart';
import '../repository/movies_repo.dart';
import '../service/init_getit.dart';
import '../service/navigation_service.dart';
import '../widgets/movies/movies_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<MovieModel> _movies = [];
  int _currentPage = 1;
  bool _isFetching = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetching) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if (_isFetching) return;
    setState(() {
      _isFetching = true;
    });
    try {
      final List<MovieModel> movies =
          await getIt<MoviesRepository>().fetchMovies(page: _currentPage);
      setState(() {
        _movies.addAll(movies);
        _currentPage++;
      });
    } catch (error) {
      getIt<NavigationService>()
          .showSnackbar("An Error has been occured $error");
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () async {
              // final List<MovieModel> movies = await getIt<ApiService>().fetchMovies();
              // log("movies $movies");
              // final List<MoviesGenre> genres =
              //     await getIt<MoviesRepository>().fetchGenres();
              // await getIt<ApiService>().fetchGenres();

              // log("Genres are $genres");
            },
            icon: const Icon(
              MyAppIcons.darkMode,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _movies.length + (_isFetching ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _movies.length) {
            return MoviesWidget(
              movieModel: _movies[index],
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
