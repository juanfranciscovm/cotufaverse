import 'dart:convert';
import "package:cotufaverse/models/models.dart";

class GenreResponse {
  GenreResponse({required this.genres});

  List<Genre> genres;
  factory GenreResponse.fromJson(String str) =>
      GenreResponse.fromMap(json.decode(str));
  factory GenreResponse.fromMap(Map<String, dynamic> json) => GenreResponse(
    genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
  );
}
