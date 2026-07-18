import 'package:cotufaverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:cotufaverse/widgets/widgets.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({
    super.key,
    required this.movies,
    required this.nextMoviePage,
  });

  final List<Movie> movies;
  final VoidCallback nextMoviePage;

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  final ScrollController _scrollController = ScrollController();
  final double _aspectRatio = 2 / 3;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxPosition = _scrollController.position.maxScrollExtent;
a
      if (currentPosition >= maxPosition - 200) {
        widget.nextMoviePage();
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
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return PosterMovieCard(
            movie: widget.movies[index],
            itemHeight: itemHeight,
            itemWidth: itemWidth,
            index: index,
          );
        },
      ),
    );
  }
}
