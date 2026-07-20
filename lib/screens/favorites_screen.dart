import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import "package:cotufaverse/utils/app_dictionary.dart";

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.watch<MoviesProvider>();
    final favoriteMovies = moviesProvider.favoriteMovies;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
        title: TextWithDoubleColor(
          size: size,
          text1: AppDictionary.translate(context, "favorites"),
          text2: ".",
          padding: const EdgeInsets.all(20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: favoriteMovies.isEmpty
              ? emptyState(context)
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: CardGrip(movies: favoriteMovies),
                ),
        ),
      ),
    );
  }

  Widget emptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 80,
            color: Color.fromARGB(55, 255, 255, 255),
          ),
          SizedBox(height: 20),
          Text(
            AppDictionary.translate(context, "no_favorites"),
            style: TextStyle(
              fontFamily: "AgrandirWide",
              fontSize: 18,
              color: Color.fromARGB(179, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
