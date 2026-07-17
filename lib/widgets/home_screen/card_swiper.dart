import 'package:cotufaverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:cotufaverse/widgets/widgets.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.movies});

  final List<Movie> movies;

  final double _aspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double maxItemWidth = size.width * 0.6;
    final double maxItemHeight = size.height * 0.6;
    final double itemWidth = (maxItemHeight * _aspectRatio).clamp(
      0.0,
      maxItemWidth,
    );
    final double itemHeight = itemWidth / _aspectRatio;

    return SizedBox(
      width: size.width,
      height: itemHeight,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return PosterMovieCard(
            movie: movies[index],
            itemHeight: itemHeight,
            itemWidth: itemWidth,
            index: index,
          );
        },
      ),
    );
  }
}
