import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:cotufaverse/models/models.dart";
import "package:shared_preferences/shared_preferences.dart";

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "064437f6febb1ef7fba652cf84100a26";
  final String _baseUrl = "api.themoviedb.org";
  String _language = "es-VE";
  bool _hideAdultContent = false;

  List<Movie> playingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Genre> movieGenres = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;
  int _topRatedPage = 0;
  int _upcomingPage = 0;

  MoviesProvider() {
    _loadInitialSettings();
  }
  void _loadInitialSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnglish = prefs.getBool("isEnglish") ?? false;

    _language = isEnglish ? "en-US" : "es-VE";
    _hideAdultContent = prefs.getBool("hideAdultContent") ?? false;

    getPlayingMovies();
    getPopularMovies();
    getMovieGenres();
    getTopRatedMovies();
    getUpcomingMovies();
  }

  //limpiar los datos
  void _resetAndFetch() {
    playingMovies.clear();
    popularMovies.clear();
    topRatedMovies.clear();
    upcomingMovies.clear();
    movieGenres.clear();
    movieCast.clear();
    _popularPage = 0;

    getPlayingMovies();
    getPopularMovies();
    getMovieGenres();
    getTopRatedMovies();
    getUpcomingMovies();

    notifyListeners();
  }

  void updateLanguage(bool isEnglish) {
    _language = isEnglish ? "en-US" : "es-VE";
    _resetAndFetch();
  }

  void updateAdultContent(bool hide) {
    _hideAdultContent = hide;
    _resetAndFetch();
  }

  Future<String> _getJsonData(String endpoint, [int? page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      "api_key": _apiKey,
      "language": _language,
      "page": "$page",
      "include_adult": _hideAdultContent ? "false" : "true",
    });

    final response = await http.get(url);
    return response.body;
  }

  void getPlayingMovies() async {
    final jsonData = await _getJsonData("/3/movie/now_playing");
    final playingData = Playing.fromJson(jsonData);
    playingMovies = playingData.movie;
    notifyListeners();
  }

  void getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData("/3/movie/popular", _popularPage);
    final popularData = Popular.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularData.movie];
    notifyListeners();
  }

  void getTopRatedMovies() async {
    _topRatedPage++;
    final jsonData = await _getJsonData("/3/movie/top_rated", _topRatedPage);
    final topRatedData = TopRated.fromJson(jsonData);
    topRatedMovies = [...topRatedMovies, ...topRatedData.movie];
    notifyListeners();
  }

  void getUpcomingMovies() async {
    _upcomingPage++;
    final jsonData = await _getJsonData('3/movie/upcoming', _upcomingPage);
    final upcomingData = Upcoming.fromJson(jsonData);
    upcomingMovies = [...upcomingMovies, ...upcomingData.movie];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;
    final jsonData = await _getJsonData("3/movie/$movieId/credits");
    final creditsData = Credits.fromJson(jsonData);
    movieCast[movieId] = creditsData.cast;
    return creditsData.cast;
  }

  void getMovieGenres() async {
    final url = Uri.https(_baseUrl, "3/genre/movie/list", {
      "api_key": _apiKey,
      "language": _language,
    });
    final response = await http.get(url);
    final genreResponse = GenreResponse.fromJson(response.body);
    movieGenres = genreResponse.genres;
    final String allText = _language == "en-US" ? "ALL" : "TODOS";
    movieGenres.insert(0, Genre(id: 0, name: allText));
    notifyListeners();
  }

  Future<List<Movie>> getMovieGenre(int genreId) async {
    final url = Uri.https(_baseUrl, "3/discover/movie", {
      "api_key": _apiKey,
      "language": _language,
      "with_genres": "$genreId",
      "include_adult": _hideAdultContent ? "false" : "true",
    });
    final response = await http.get(url);
    final discoverResponse = Search.fromJson(response.body);
    return discoverResponse.results;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, "3/search/movie", {
      "api_key": _apiKey,
      "language": _language,
      "query": query,
      "include_adult": _hideAdultContent ? "false" : "true",
    });
    final response = await http.get(url);
    final searchResponse = Search.fromJson(response.body);
    return searchResponse.results;
  }
}
