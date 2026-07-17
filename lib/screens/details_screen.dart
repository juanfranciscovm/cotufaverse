import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";
import "package:cotufaverse/widgets/widgets.dart";

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movieModal =
        ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          MovieDetailsAppbar(movie: movieModal),
          SliverList(
            delegate: SliverChildListDelegate([
              PosterAndTitle(movie: movieModal),
              MovieOverview(movie: movieModal),
              CastingCards(movie: movieModal),
            ]),
          ),
        ],
      ),
    );
  }
}
