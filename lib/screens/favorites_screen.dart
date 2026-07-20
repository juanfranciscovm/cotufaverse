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
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Color(0xFF0C123F),
        ),
        toolbarHeight: size.height * 0.1,
        title: TextWithDoubleColor(
          size: size,
          text1: AppDictionary.translate(context, "favorites"),
          text2: ".",
          padding: const EdgeInsets.all(20.0),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Color.fromARGB(255, 39, 52, 168), Color(0xFF080B27)]
                : [Colors.white, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: favoriteMovies.isEmpty
                ? emptyState(context)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: CardGrip(movies: favoriteMovies),
                  ),
          ),
        ),
      ),
    );
  }

  Widget emptyState(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              AppDictionary.translate(context, "no_favorites"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "AgrandirWide",
                fontSize: 18,
                color: isDarkMode
                  ? Color.fromARGB(179, 255, 255, 255)
                  : Color.fromARGB(179, 9, 7, 7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
