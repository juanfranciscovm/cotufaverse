import 'package:cotufaverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PosterMovieCard extends StatelessWidget {
  const PosterMovieCard({
    super.key,
    required this.itemHeight,
    required this.index,
    required this.itemWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    required this.movie,
  });

  final Movie movie;
  final double itemHeight;
  final double itemWidth;
  final int index;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    int score = movie.voteAverage.round();

    Color starEnable1 = (score == 0) ? Colors.transparent : const Color(0xFFF7C53A);
    Color starEnable2 = (score <= 2) ? Colors.transparent : const Color(0xFFF7C53A);
    Color starEnable3 = (score <= 4) ? Colors.transparent : const Color(0xFFF7C53A);
    Color starEnable4 = (score <= 6) ? Colors.transparent : const Color(0xFFF7C53A);
    Color starEnable5 = (score <= 8) ? Colors.transparent : const Color(0xFFF7C53A);

    return SizedBox(
      height: itemHeight,
      width: itemWidth,
      child: Padding(
        padding: padding,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox.expand(
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  image: NetworkImage(movie.fullPosterPath),
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
                      movie.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: itemHeight * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              score >= 2 ? Icons.star : Icons.star_half,
                              color: starEnable1,
                              size: itemHeight * 0.05,
                            ),
                            Icon(
                              score >=  4? Icons.star : Icons.star_half,
                              color: starEnable2,
                              size: itemHeight * 0.05,
                            ),
                            Icon(
                              score >=  6? Icons.star : Icons.star_half,
                              color: starEnable3,
                              size: itemHeight * 0.05,
                            ),
                            Icon(
                              score >=  8? Icons.star : Icons.star_half,
                              color: starEnable4,
                              size: itemHeight * 0.05,
                            ),
                            Icon(
                              score >=  10? Icons.star : Icons.star_half,
                              color: starEnable5,
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
            Positioned(
              top: 10,
              right: 10,
              child: movie.adult ? Icon(
                Icons.eighteen_up_rating_outlined,
                color: Colors.white,
                size: itemHeight * 0.125,
              ) : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
