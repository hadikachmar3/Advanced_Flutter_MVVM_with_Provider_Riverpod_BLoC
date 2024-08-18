class MoviesGenre {
  final int id;
  final String name;
  MoviesGenre({required this.id, required this.name});

  factory MoviesGenre.fromJson(Map<String, dynamic> json) {
    return MoviesGenre(id: json['id'], name: json['name']);
  }
  @override
  String toString() {
    return "MoviesGenre(id: $id, name: $name)";
  }
}
