import 'package:flutter/material.dart';
import 'package:cotufaverse/widgets/widgets.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  static const double _aspectRatio = 2 / 3;

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
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: itemHeight,
            width: itemWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PosterMovieCard(itemHeight: itemHeight, index: index),
            ),
          );
        },
      ),
    );
  }
}

