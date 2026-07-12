import 'package:flutter/material.dart';

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
    final double maxItemHeight = size.height * 0.3;
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

class PosterMovieCard extends StatelessWidget {
  const PosterMovieCard({
    super.key,
    required this.itemHeight,
    required this.index,
  });

  final double itemHeight;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: SizedBox.expand(
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/images/loading.gif'),
              image: NetworkImage(
                'https://picsum.photos/200/300?random=$index',
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.5),
                Colors.black.withValues(alpha: 0.7),
                Colors.black,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'El asesinato de Jesse James por el cobarde Robert Ford',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: itemHeight * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '10/10',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: itemHeight * 0.05,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: const Color(0xFFF7C53A),
                          size: itemHeight * 0.05,
                        ),
                        Icon(
                          Icons.star,
                          color: const Color(0xFFF7C53A),
                          size: itemHeight * 0.05,
                        ),
                        Icon(
                          Icons.star,
                          color: const Color(0xFFF7C53A),
                          size: itemHeight * 0.05,
                        ),
                        Icon(
                          Icons.star,
                          color: const Color(0xFFF7C53A),
                          size: itemHeight * 0.05,
                        ),
                        Icon(
                          Icons.star,
                          color: const Color(0xFFF7C53A),
                          size: itemHeight * 0.05,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
