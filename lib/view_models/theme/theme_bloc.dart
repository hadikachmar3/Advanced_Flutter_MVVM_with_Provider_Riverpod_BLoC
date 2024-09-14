import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/my_theme_data.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<LoadThemeEvent>(_loadTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }
  final prefsKey = "isDarkMode";
  Future<void> _loadTheme(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(prefsKey) ?? true;
    if (isDarkMode) {
      emit(DarkThemeState(themeData: MyThemeData.darkTheme));
    } else {
      emit(LightThemeState(themeData: MyThemeData.lightTheme));
    }
  }

  Future<void> _toggleTheme(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final currentState = state;

    if (currentState is LightThemeState) {
      emit(DarkThemeState(themeData: MyThemeData.darkTheme));
      await prefs.setBool(prefsKey, true);
    } else {
      emit(LightThemeState(themeData: MyThemeData.lightTheme));
      await prefs.setBool(prefsKey, false);
    }
  }
}
