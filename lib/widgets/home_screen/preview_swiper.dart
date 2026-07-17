import 'package:card_swiper/card_swiper.dart';
import 'package:cotufaverse/widgets/home_screen/category_label.dart';
import 'package:cotufaverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewSwiper extends StatelessWidget {
  const PreviewSwiper({super.key, required this.movies, required this.genres});

  final List<Movie> movies;
  final List<Genre> genres;

  static const double _aspectRatio = 4 / 9;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxItemHeight = size.height * 0.75;
    final itemWidth = size.width;
    final itemHeight = (itemWidth / _aspectRatio).clamp(0.0, maxItemHeight);

    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: Swiper(
          autoplayDisableOnInteraction: true,
          autoplay: true,
          autoplayDelay: 30000,
          pagination: const SwiperPagination(),
          control: const SwiperControl(color: Colors.white),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                SizedBox.expand(
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(
                      size.height > size.width
                          ? movies[index].fullPosterPath
                          : movies[index].fullBackdropPath,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movies[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: itemHeight * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${movies[index].voteAverage.toStringAsFixed(2)}/10',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: itemHeight * 0.03,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.star,
                            color: const Color(0xFFF7C53A),
                            size: itemHeight * 0.07,
                          ),
                          const SizedBox(width: 5),
                          movies[index].adult ? Icon(
                            Icons.eighteen_up_rating_outlined,
                            color: Colors.white,
                            size: itemHeight * 0.07,
                          ) : const SizedBox(),
                        ],
                      ),
                      const SizedBox(),
                      Text(
                        movies[index].overview.isNotEmpty ? movies[index].overview : 'No se encontro una descripción',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          height: 1.8,
                          color: Colors.white,
                          fontSize: itemHeight * 0.03,
                        ),
                      ),

                      const SizedBox(height: 10),
                      SizedBox(
                        height: itemHeight * 0.095,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: movies[index].genreIds.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, genreIndex) {
                            final genreId = movies[index].genreIds[genreIndex];

                            final genre = genres.firstWhere(
                              (g) => g.id == genreId,
                              orElse: () => Genre(id: 0, name: 'Sin Genero'),
                            );
                            
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: CategoryLabel(
                                itemHeight: itemHeight,
                                category: genre.name,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
