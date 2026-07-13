import 'dart:convert';
import 'package:cotufaverse/models/models.dart';

class Popular {
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  Popular({
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory Popular.fromJson(String str) => Popular.fromMap(json.decode(str));

  factory Popular.fromMap(Map<String, dynamic> json) => Popular(
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
