part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final MovieModel movieModel;

  const AddToFavorites({required this.movieModel});
  @override
  List<Object> get props => [movieModel];
}

class RemoveFromFavorites extends FavoritesEvent {
  final MovieModel movieModel;

  const RemoveFromFavorites({required this.movieModel});
  @override
  List<Object> get props => [movieModel];
}

class RemoveAllFromFavorites extends FavoritesEvent {}
