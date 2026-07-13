import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:cotufaverse/models/models.dart";

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "064437f6febb1ef7fba652cf84100a26";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-VE";

  List<Movie> playingMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int? page = 1]) async {
    var url = Uri.http(_baseUrl, endpoint, {
      "api_key": _apiKey,
      "language": _language,
      "page": "$page",
    });

    final response = await http.get(url);
    return response.body;
  }

  getPlayingMovies() async {
    final jsonData = await _getJsonData("/3/movie/now_playing");
    final playingData = Playing.fromJson(jsonData);
    playingMovies = playingData.movie;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData("/3/movie/popular", _popularPage);
    final popularData = Popular.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularData.movie];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final jsonData = await _getJsonData("3/movie/$movieId/credits");
    final creditsData = Credits.fromJson(jsonData);
    movieCast[movieId] = creditsData.cast;
    return creditsData.cast;
  }
}
