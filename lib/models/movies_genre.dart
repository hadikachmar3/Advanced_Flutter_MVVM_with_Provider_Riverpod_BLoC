import 'package:equatable/equatable.dart';

class MoviesGenre extends Equatable {
  final int id;
  final String name;
  const MoviesGenre({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];

  factory MoviesGenre.fromJson(Map<String, dynamic> json) {
    return MoviesGenre(id: json['id'], name: json['name']);
  }
  @override
  String toString() {
    return "MoviesGenre(id: $id, name: $name)";
  }
}
