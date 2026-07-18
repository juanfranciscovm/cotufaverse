import 'dart:convert';
import 'package:cotufaverse/models/models.dart';

class Discover {
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  Discover({
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory Discover.fromJson(String str) => Discover.fromMap(json.decode(str));

  factory Discover.fromMap(Map<String, dynamic> json) => Discover(
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
