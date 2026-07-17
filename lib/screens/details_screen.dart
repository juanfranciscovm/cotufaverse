import "dart:ui";
import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";
import "package:cotufaverse/widgets/widgets.dart";

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movieModal =
        ModalRoute.of(context)!.settings.arguments as Movie;
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
                  MovieOverview(movie: movieModal),
                  CastingCards(movie: movieModal),
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
