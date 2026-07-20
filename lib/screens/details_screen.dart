import "dart:ui";
import "package:provider/provider.dart";
import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";
import "package:cotufaverse/widgets/widgets.dart";
import "package:cotufaverse/provider/movies_provider.dart";

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movieModal =
        ModalRoute.of(context)!.settings.arguments as Movie;
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    final Future<List<Movie>> movies = moviesProvider.getRecommendations(
      movieModal,
    );

    final genres = moviesProvider.movieGenres
        .where((g) => movieModal.genreIds.contains(g.id))
        .toList();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color overlayColor = isDark
        ? const Color.fromARGB(211, 12, 18, 63)
        : const Color.fromARGB(200, 248, 240, 204);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movieModal.fullBackdropPath,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                color: isDark
                    ? const Color(0xFF0C123F)
                    : const Color(0xFFF8F0CC),
              ),
            ),
          ),
          //desenfoque
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(color: overlayColor),
            ),
          ),
          CustomScrollView(
            slivers: [
              MovieDetailsAppbar(movie: movieModal),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 20),
                  if (genres.isNotEmpty)
                    Container(
                      height: 35,
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: genres.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index == genres.length - 1 ? 0 : 10,
                            ),
                            child: CategoryLabel(category: genres[index].name),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 10),
                  MovieOverview(movie: movieModal),
                  CastingCards(movie: movieModal),
                  FutureBuilder(
                    future: movies,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CardSwiper(
                        movies: snapshot.data!,
                        nextMoviePage: () {},
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
