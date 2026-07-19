import 'package:cotufaverse/models/genre.dart';
import 'package:cotufaverse/models/movie.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSwiper extends StatefulWidget {
  const DetailSwiper({
    super.key,
    required this.movies,
    required this.genres,
    required this.nextMoviePage,
  });

  final List<Movie> movies;
  final List<Genre> genres;

  final VoidCallback nextMoviePage;

  @override
  State<DetailSwiper> createState() => _DetailSwiperState();
}

class _DetailSwiperState extends State<DetailSwiper> {
  final double _aspectRatioCard = 3 / 2;

  final double _aspectRatioImage = 2 / 3;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double currentPosition = _scrollController.position.pixels;
      double maxPosition = _scrollController.position.maxScrollExtent;

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

    final double maxItemWidth = size.width;
    final double maxcardHeight = size.height * 0.6;
    final double cardWidth = (maxcardHeight * _aspectRatioCard).clamp(
      0.0,
      maxItemWidth,
    );

    final double cardHeight = cardWidth / _aspectRatioCard;

    final double imageWidth = cardHeight * _aspectRatioImage;

    return SizedBox(
      width: size.width,
      height: cardHeight,

      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: cardHeight,
              width: cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: widget.movies[index],
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: cardHeight,
                        width: imageWidth,
                        child: Hero(
                          tag: widget.movies[index].heroId,
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage(
                              'assets/images/loading.gif',
                            ),
                            image: NetworkImage(
                              widget.movies[index].fullPosterPath,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            SizedBox.expand(
                              child: FadeInImage(
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                  'assets/images/loading.gif',
                                ),
                                image: NetworkImage(
                                  widget.movies[index].fullBackdropPath,
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black54, Colors.black],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.movies[index].title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: cardHeight * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${widget.movies[index].voteAverage.toStringAsFixed(2)}/10',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: cardHeight * 0.03,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        Icons.star,
                                        color: const Color(0xFFF7C53A),
                                        size: cardHeight * 0.07,
                                      ),
                                      const SizedBox(width: 5),
                                      widget.movies[index].adult
                                          ? Icon(
                                              Icons.eighteen_up_rating_outlined,
                                              color: Colors.white,
                                              size: cardHeight * 0.07,
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                  const SizedBox(),
                                  Text(
                                    widget.movies[index].overview.isNotEmpty
                                        ? widget.movies[index].overview
                                        : 'No se encontro una descripción',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.poppins(
                                      height: 1.8,
                                      color: Colors.white,
                                      fontSize: cardHeight * 0.03,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: cardHeight * 0.125,
                                    child: ListView.builder(
                                      itemCount:
                                          widget.movies[index].genreIds.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, genreIndex) {
                                        final genreId = widget
                                            .movies[index]
                                            .genreIds[genreIndex];

                                        final genre = widget.genres.firstWhere(
                                          (g) => g.id == genreId,
                                          orElse: () =>
                                              Genre(id: 0, name: 'Sin Genero'),
                                        );

                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: CategoryLabel(
                                            itemHeight: cardHeight,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
