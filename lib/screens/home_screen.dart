import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import "package:cotufaverse/utils/app_dictionary.dart";
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        size: size,
        searchButtonAction: () {},
        menuButtonAction: () {},
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PreviewSwiper(
                movies: moviesProvider.playingMovies,
                genres: moviesProvider.movieGenres,
              ),
              // Poner al configurar el usuario, si no borrar
              // TextWithDoubleColor(
              //   size: size,
              //   text1: 'Películas ',
              //   text2: 'Recomendadas',
              // ),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "top_movies"),
                text2: '.',
              ),
              CardSwiper(movies: moviesProvider.topRatedMovies),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "popular_movies"),
                text2: '.',
                alignment: Alignment.centerRight,
              ),
              CardSwiper(movies: moviesProvider.popularMovies),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "upcoming"),
                text2: AppDictionary.translate(context, "upcoming_movies"),
              ),
              DetailSwiper(
                movies: moviesProvider.upcomingMovies,
                genres: moviesProvider.movieGenres,
              ),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "movie_directory"),
                text2: '.',
                alignment: Alignment.center,
              ),
              OrderByDropdownMenu(),
              CardGrip(movies: moviesProvider.playingMovies),
              SizedBox(height: size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
