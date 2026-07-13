import 'dart:convert';

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String title;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  bool softcore;
  bool video;
  double voteAverage;
  int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.softcore,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  String? heroId;

  String get fullPosterPath {
    if (posterPath != null) {
      return "https://image.tmdb.org/t/p/w500/$posterPath";
    }
    return "https://drive.google.com/uc?export=view&id=1LHJGcro_jorwHcN58AT-hYDV_Lr-xBxL";
  }

  String get fullBackdropPath {
    if (backdropPath != null) {
      return "https://image.tmdb.org/t/p/w500/$backdropPath";
    }
    return "https://drive.google.com/uc?export=view&id=1LHJGcro_jorwHcN58AT-hYDV_Lr-xBxL";
  }

  factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

  factory Movie.fromMap(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    title: json["title"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    softcore: json["softcore"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
  );
}
