import 'dart:convert';
import 'package:cotufaverse/models/models.dart';

class Upcoming {
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  Upcoming({
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory Upcoming.fromJson(String str) => Upcoming.fromMap(json.decode(str));

  factory Upcoming.fromMap(Map<String, dynamic> json) => Upcoming(
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
