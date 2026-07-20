import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import "package:cotufaverse/utils/app_dictionary.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.moviesProvider});

  final MoviesProvider moviesProvider;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? activateButtonPosition;
  bool activateButton = false;

  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _favoritesKey = GlobalKey();
  final GlobalKey _topMoviesKey = GlobalKey();
  final GlobalKey _popularKey = GlobalKey();
  final GlobalKey _upcomingKey = GlobalKey();
  final GlobalKey _directoryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxPosition = _scrollController.position.maxScrollExtent;

      if (activateButton && (currentPosition < activateButtonPosition!)) {
        setState(() {
          activateButton = false;
        });
      }

      if ((activateButtonPosition != null) &&
          (currentPosition >= activateButtonPosition!)) {
        if (!activateButton) {
          setState(() {
            activateButton = true;
          });
        }
      }

      if (currentPosition >= maxPosition - 200) {
        activateButtonPosition ??= maxPosition;
        widget.moviesProvider.getDiscoverMovies();
        if (!activateButton) activateButton = true;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey sectionKey) {
    Navigator.pop(context);

    if (sectionKey.currentContext != null) {
      Scrollable.ensureVisible(
        sectionKey.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: (size.height * 0.1).clamp(60, size.height),
        ),
        child: activateButton
            ? FloatingActionButton(
                child: const Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    activateButton = false;
                  });
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              )
            : const SizedBox(),
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        backgroundColor: isDarkMode ? const Color(0xFF0C123F) : Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Image.asset(isDarkMode ?  'assets/images/logoCotufaVerse.png' : 'assets/images/logoCotufaVerseDark.png' ),
              ),
            ),
            widget.moviesProvider.login &&
                    widget.moviesProvider.favoriteMovies.isNotEmpty
                ? ListTile(
                    leading: const Icon(Icons.favorite),
                    title: Text(AppDictionary.translate(context, 'favorites')),
                    onTap: () => _scrollToSection(_favoritesKey),
                  )
                : const SizedBox(),
            ListTile(
              leading: const Icon(Icons.star),
              title: Text(AppDictionary.translate(context, 'top_movies')),
              onTap: () => _scrollToSection(_topMoviesKey),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: Text(AppDictionary.translate(context, 'popular_movies')),
              onTap: () => _scrollToSection(_popularKey),
            ),
            ListTile(
              leading: const Icon(Icons.new_releases),
              title: Text(
                AppDictionary.translate(context, 'upcoming') +
                    AppDictionary.translate(context, 'upcoming_movies'),
              ),
              onTap: () => _scrollToSection(_upcomingKey),
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: Text(AppDictionary.translate(context, 'movie_directory')),
              onTap: () => _scrollToSection(_directoryKey),
            ),
          ],
        ),
      ),
      appBar: CustomAppBar(
        size: size,
        searchButtonAction: () {
          Navigator.pushNamed(context, '/search');
        },
        menuButtonAction: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SafeArea(
          top: false,
          bottom: false,
          right: false,
          left: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PreviewSwiper(
                movies: widget.moviesProvider.playingMovies,
                genres: widget.moviesProvider.movieGenres,
              ),
              // Poner al configurar el usuario, si no borrar
              widget.moviesProvider.login &&
                      widget.moviesProvider.favoriteMovies.isNotEmpty
                  ? TextWithDoubleColor(
                      key: _favoritesKey,
                      size: size,
                      text1: AppDictionary.translate(context, 'favorites'),
                      text2: '.',
                    )
                  : const SizedBox(),
              widget.moviesProvider.login &&
                      widget.moviesProvider.favoriteMovies.isNotEmpty
                  ? CardSwiper(
                      movies: widget.moviesProvider.favoriteMovies,
                      nextMoviePage: widget.moviesProvider.getFavoriteMovies,
                    )
                  : const SizedBox(),
              TextWithDoubleColor(
                key: _topMoviesKey,
                size: size,
                text1: AppDictionary.translate(context, "top_movies"),
                text2: '.',
              ),
              CardSwiper(
                movies: widget.moviesProvider.topRatedMovies,
                nextMoviePage: widget.moviesProvider.getTopRatedMovies,
              ),
              TextWithDoubleColor(
                key: _popularKey,
                size: size,
                text1: AppDictionary.translate(context, "popular_movies"),
                text2: '.',
              ),
              CardSwiper(
                movies: widget.moviesProvider.popularMovies,
                nextMoviePage: widget.moviesProvider.getPopularMovies,
              ),
              TextWithDoubleColor(
                key: _upcomingKey,
                size: size,
                text1: AppDictionary.translate(context, "upcoming"),
                text2: AppDictionary.translate(context, "upcoming_movies"),
              ),
              DetailSwiper(
                movies: widget.moviesProvider.upcomingMovies,
                genres: widget.moviesProvider.movieGenres,
                nextMoviePage: widget.moviesProvider.getUpcomingMovies,
              ),
              TextWithDoubleColor(
                key: _directoryKey,
                size: size,
                text1: AppDictionary.translate(context, "movie_directory"),
                text2: '.',
                alignment: Alignment.center,
              ),
              const OrderByDropdownMenu(),
              CardGrip(movies: widget.moviesProvider.discoverMovies),
              SizedBox(height: size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
