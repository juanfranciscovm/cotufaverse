import 'package:cotufaverse/models/models.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardGrip extends StatelessWidget {
  const CardGrip({super.key, required this.movies});

  final List<Movie> movies;

  static const double _aspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double maxItemHeight = size.height * 0.5;

    final double maxItemWidth = _aspectRatio * maxItemHeight;

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        maxCrossAxisExtent: maxItemWidth,
        childAspectRatio: _aspectRatio,
      ),
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return LayoutBuilder(
          builder: (contex, constrains) {
            return PosterMovieCard(
              movie: movies[index],
              itemHeight: constrains.maxHeight,
              index: index,
              itemWidth: constrains.maxWidth,
              padding: const EdgeInsets.all(0),
            );
          },
        );
      },
    );
  }
}
