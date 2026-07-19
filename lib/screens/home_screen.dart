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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: (size.height * 0.1).clamp(60, size.height),
        ),
        child: activateButton
            ? FloatingActionButton(
                child: const Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    activateButton = activateButton = false;
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
      appBar: CustomAppBar(
        size: size,
        searchButtonAction: () {},
        menuButtonAction: () {},
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
              widget.moviesProvider.login && widget.moviesProvider.favoriteMovies.isNotEmpty
                  ? TextWithDoubleColor(
                      size: size,
                      text1: 'Favoritos ',
                      text2: '.',
                    )
                  : const SizedBox(),
              widget.moviesProvider.login && widget.moviesProvider.favoriteMovies.isNotEmpty
                  ? CardSwiper(
                      movies: widget.moviesProvider.favoriteMovies,
                      nextMoviePage: widget.moviesProvider.getFavoriteMovies,
                    )
                  : const SizedBox(),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "top_movies"),
                text2: '.',
              ),
              CardSwiper(
                movies: widget.moviesProvider.topRatedMovies,
                nextMoviePage: widget.moviesProvider.getTopRatedMovies,
              ),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "popular_movies"),
                text2: '.',
              ),
              CardSwiper(
                movies: widget.moviesProvider.popularMovies,
                nextMoviePage: widget.moviesProvider.getPopularMovies,
              ),
              TextWithDoubleColor(
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
