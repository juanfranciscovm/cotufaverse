import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:cotufaverse/models/models.dart";

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "064437f6febb1ef7fba652cf84100a26";
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-VE";

  List<Movie> playingMovies = [];
  List<Movie> popularMovies = [];
  List<Genre> movieGenres = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;

  MoviesProvider() {
    getPlayingMovies();
    getPopularMovies();
    getMovieGenres();
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

  getMovieGenres() async {
    final url = Uri.https(_baseUrl, "3/genre/movie/list", {
      "api_key": _apiKey,
      "language": _language,
    });
    final response = await http.get(url);
    final genreResponse = GenreResponse.fromJson(response.body);
    movieGenres = genreResponse.genres;
    movieGenres.insert(0, Genre(id: 0, name: "TODOS"));
    notifyListeners();
  }

  //busca películas según el botón de género
  Future<List<Movie>> getMovieGenre(int genreId) async {
    final url = Uri.https(_baseUrl, "3/discover/movie", {
      "api_key": _apiKey,
      "language": _language,
      "with_genres": "$genreId",
    });
    final response = await http.get(url);
    final discoverResponse = Search.fromJson(response.body);
    return discoverResponse.results;
  }

  //busca películas al escribir en la barra
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie", {
      "api_key": _apiKey,
      "language": _language,
      "query": query,
    });
    final response = await http.get(url);
    final searchResponse = Search.fromJson(response.body);
    return searchResponse.results;
  }
}
