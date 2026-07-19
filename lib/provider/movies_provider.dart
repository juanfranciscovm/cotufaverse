import "dart:convert";

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:cotufaverse/models/models.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:url_launcher/url_launcher.dart";

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = "064437f6febb1ef7fba652cf84100a26";
  final String _baseUrl = "api.themoviedb.org";
  String? _sessionID;
  Account? account;
  bool login = false;
  String _language = "es-VE";
  bool _hideAdultContent = true;
  OrderBy selectedOrderByDiscover = OrderBy.popular;
  bool orderDescDiscover = true;

  List<Movie> playingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> discoverMovies = [];
  List<Genre> movieGenres = [];
  List<Movie> favoriteMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;
  int _topRatedPage = 0;
  int _upcomingPage = 0;
  int _discoverPage = 0;
  int _favoritePage = 0;

  MoviesProvider() {
    _loadInitialSettings();
  }
  void _loadInitialSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final isEnglish = prefs.getBool("isEnglish") ?? false;

    _language = isEnglish ? "en-US" : "es-VE";
    _hideAdultContent = prefs.getBool("hideAdultContent") ?? false;

    _sessionID = prefs.getString('session_id');
    login = _sessionID != null;

    if (login) {
      await getAccount();
      getFavoriteMovies();
    }

    getPlayingMovies();
    getPopularMovies();
    getMovieGenres();
    getTopRatedMovies();
    getUpcomingMovies();
    getDiscoverMovies();
  }

  //limpiar los datos
  void _resetAndFetch() async {
    playingMovies.clear();
    popularMovies.clear();
    topRatedMovies.clear();
    upcomingMovies.clear();
    discoverMovies.clear();
    movieGenres.clear();
    movieCast.clear();
    account = null;
    favoriteMovies.clear();

    _popularPage = 0;
    _topRatedPage = 0;
    _upcomingPage = 0;
    _discoverPage = 0;
    _favoritePage = 0;

    getPlayingMovies();
    getPopularMovies();
    getMovieGenres();
    getTopRatedMovies();
    getUpcomingMovies();
    getDiscoverMovies();
    if (login) {
      await getAccount();
      getFavoriteMovies();
    }
    notifyListeners();
  }

  void newDiscoverOrder() {
    discoverMovies.clear();

    _discoverPage = 0;

    getDiscoverMovies();

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

  Future<String> _getJsonData(
    String endpoint, [
    int? page = 1,
    Map<String, String>? options,
  ]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      "api_key": _apiKey,
      "language": _language,
      "page": "$page",
      "include_adult": _hideAdultContent ? "false" : "true",
      ...?options?.cast<String, String>(),
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
    final popularData = Favorites.fromJson(jsonData);
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

  String orderCalculator() {
    switch (selectedOrderByDiscover) {
      case OrderBy.popular:
        if (orderDescDiscover) return 'popularity.desc';
        return 'popularity.asc';
      case OrderBy.releaseDate:
        if (orderDescDiscover) return 'primary_relase_date.desc';
        return 'primary_relase_date.asc';
      case OrderBy.score:
        if (orderDescDiscover) return 'vote_average.desc';
        return 'vote_average.asc';
    }
  }

  void getDiscoverMovies() async {
    _discoverPage++;
    final jsonData = await _getJsonData('3/discover/movie', _discoverPage, {
      'sort_by': orderCalculator(),
    });
    final discoverData = Discover.fromJson(jsonData);
    discoverMovies = [...discoverMovies, ...discoverData.movie];
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

  Future getRequestToken() async {
    final url = Uri.https(_baseUrl, '3/authentication/token/new', {
      'api_key': _apiKey,
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final requestTokenResponse = jsonDecode(response.body);
      return requestTokenResponse['request_token'];
    }
    return null;
  }

  Future authorizeToken(String token) async {
    final String redirectUrl = 'cotufaverse://callback';

    final authUrl = Uri.parse(
      'https://www.themoviedb.org/authenticate/$token?redirect_to=$redirectUrl',
    );

    if (await canLaunchUrl(authUrl)) {
      await launchUrl(authUrl, mode: LaunchMode.externalApplication);
      return true;
    } else {
      return false;
    }
  }

  Future createSession(String approvedToken) async {
    final url = Uri.https(_baseUrl, '3/authentication/session/new', {
      'api_key': _apiKey,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'request_token': approvedToken}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _sessionID = data['session_id'];
      login = true;
      await getAccount();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('session_id', _sessionID!);

      notifyListeners();

      return true;
    }
    return false;
  }

  void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');

    _sessionID = null;
    login = false;

    notifyListeners();
  }

  Future getAccount() async {
    if (_sessionID == null) return;

    final url = Uri.https(_baseUrl, '3/account', {
      'api_key': _apiKey,
      'session_id': _sessionID,
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      account = Account.fromJson(response.body);
    }
  }

  void getFavoriteMovies() async {
    _favoritePage++;
    final url =
        Uri.https(_baseUrl, '3/account/${account!.id}/favorite/movies', {
          'api_key': _apiKey,
          'session_id': _sessionID,
          'language': _language,
          'page': _favoritePage.toString(),
        });

    final response = await http.get(url);

    final favoritesResponse = Favorites.fromJson(response.body);

    favoriteMovies = [...favoriteMovies, ...favoritesResponse.movie];
    notifyListeners();
  }

  Future<bool> toogleFavorite(Movie movie, bool isFavorite) async {
    if (_sessionID == null || account == null) return false;

    final url = Uri.https(_baseUrl, '3/account/${account!.id}/favorite', {
      'api_key': _apiKey,
      'session_id': _sessionID,
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'media_type': 'movie',
        'media_id': movie.id,
        'favorite': isFavorite,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      favoriteMovies.clear();
      _favoritePage = 0;
      getFavoriteMovies();
      return true;
    }
    return false;
  }

  bool checkFavoriteMovie(Movie movie) {
    if (login == false) return false;
    bool movieInFavoriteList = favoriteMovies.any((m) => m.id == movie.id);

    return movieInFavoriteList;
  }
}

enum OrderBy { popular, score, releaseDate }
