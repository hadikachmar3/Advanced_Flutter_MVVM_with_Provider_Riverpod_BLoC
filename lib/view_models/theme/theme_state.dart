part of 'theme_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState {}

final class LightThemeState extends ThemeState {
  final ThemeData themeData;

  const LightThemeState({required this.themeData});

  @override
  List<Object> get props => [themeData];
}

final class DarkThemeState extends ThemeState {
  final ThemeData themeData;

  const DarkThemeState({required this.themeData});
  @override
  List<Object> get props => [themeData];
}

final class ThemeError extends ThemeState {}
