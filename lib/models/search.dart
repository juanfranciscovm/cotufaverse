import 'dart:convert';
import "package:cotufaverse/models/models.dart";

class Search {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  Search({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory Search.fromJson(String str) => Search.fromMap(json.decode(str));

  factory Search.fromMap(Map<String, dynamic> json) => Search(
    page: json["page"],
    results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
