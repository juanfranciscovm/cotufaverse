import 'dart:convert';
import 'package:cotufaverse/models/models.dart';

class Favorites {
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  Favorites({
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory Favorites.fromJson(String str) => Favorites.fromMap(json.decode(str));

  factory Favorites.fromMap(Map<String, dynamic> json) => Favorites(
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
