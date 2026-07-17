import 'dart:convert';
import 'package:cotufaverse/models/models.dart';

class TopRated {
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  TopRated({
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory TopRated.fromJson(String str) => TopRated.fromMap(json.decode(str));

  factory TopRated.fromMap(Map<String, dynamic> json) => TopRated(
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
