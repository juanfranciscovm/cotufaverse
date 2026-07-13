import 'dart:convert';
import "package:cotufaverse/models/models.dart";

class Playing {
  Dates dates;
  int page;
  List<Movie> movie;
  int totalPages;
  int totalResults;

  Playing({
    required this.dates,
    required this.page,
    required this.movie,
    required this.totalPages,
    required this.totalResults,
  });

  factory Playing.fromJson(String str) => Playing.fromMap(json.decode(str));

  factory Playing.fromMap(Map<String, dynamic> json) => Playing(
    dates: Dates.fromMap(json["dates"]),
    page: json["page"],
    movie: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );
}
