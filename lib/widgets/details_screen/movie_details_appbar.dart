import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";

class MovieDetailsAppbar extends StatelessWidget {
  final Movie movie;
  const MovieDetailsAppbar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final isVertical = orientation == Orientation.portrait;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark
        ? const Color(0xFFF8F0CC)
        : const Color(0xFF0C123F);
    final double expandedHeight = isVertical
        ? size.height * 0.65
        : size.height * 0.8;
    final double collapsedHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: const Color(0xFFFFC527),
      expandedHeight: expandedHeight,
      pinned: true,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final currentHeight = constraints.maxHeight;

          //expansión de la appbar al scrollear
          final double expandRatio =
              ((currentHeight - collapsedHeight) /
                      (expandedHeight - collapsedHeight))
                  .clamp(0.0, 1.0);
          final double titleBottomEnd = isVertical ? 30.0 : 80.0;
          final double titleBottom = Tween<double>(
            begin: (kToolbarHeight - 24) / 2,
            end: titleBottomEnd,
          ).transform(expandRatio);
          final double expandedLeft = isVertical
              ? 20.0
              : (size.width * 0.4) + 20.0;
          final double titleLeft = Tween<double>(
            begin: 50.0,
            end: expandedLeft,
          ).transform(expandRatio);

          final double titleRight = Tween<double>(
            begin: 50.0,
            end: 20.0,
          ).transform(expandRatio);
          final double maxTitleSize = isVertical ? 28.0 : 32.0;

          return Stack(
            fit: StackFit.expand,
            children: [
              FlexibleSpaceBar(
                background: isVertical
                    ? _PortraitBackground(movie: movie)
                    : _LandscapeBackground(movie: movie),
              ),

              Positioned(
                bottom: titleBottom,
                left: titleLeft,
                right: titleRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      //transición
                      alignment: Alignment.lerp(
                        Alignment.center,
                        Alignment.centerLeft,
                        expandRatio,
                      )!,
                      child: Text(
                        movie.title,
                        style: TextStyle(
                          fontFamily: "Agrandir",
                          fontSize: Tween<double>(
                            begin: 18,
                            end: maxTitleSize,
                          ).transform(expandRatio),
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        maxLines: expandRatio < 0.5 ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    //subtítulo  y calificación
                    ClipRect(
                      child: Align(
                        heightFactor: expandRatio,
                        alignment: Alignment.topLeft,
                        child: Opacity(
                          opacity: (expandRatio - 0.2).clamp(0.0, 1.0) / 0.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                movie.originalTitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: textColor.withValues(alpha: 0.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: Color(0xFFFFC527),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${movie.voteAverage.round()}/10",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PortraitBackground extends StatelessWidget {
  final Movie movie;
  const _PortraitBackground({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.black, Colors.transparent],
          stops: [0.0, 0.6, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: FadeInImage(
        placeholder: const AssetImage("assets/images/loading.gif"),
        image: NetworkImage(movie.fullPosterPath),
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.movie_outlined,
              size: 80,
              color: Color.fromARGB(60, 255, 255, 255),
            ),
          );
        },
      ),
    );
  }
}

class _LandscapeBackground extends StatelessWidget {
  final Movie movie;
  const _LandscapeBackground({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.only(
              left: 55,
              top: MediaQuery.of(context).padding.top + 15,
              bottom: 20,
              right: 15,
            ),
            child: Center(
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/images/loading.gif"),
                    image: NetworkImage(movie.fullPosterPath),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color.fromARGB(31, 0, 0, 0),
                        child: const Icon(
                          Icons.movie_outlined,
                          size: 50,
                          color: Color.fromARGB(60, 255, 255, 255),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black, Colors.transparent],
                stops: [0.0, 0.4, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstIn,
            child: FadeInImage(
              placeholder: const AssetImage("assets/images/loading.gif"),
              image: NetworkImage(movie.fullBackdropPath),
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.transparent);
              },
            ),
          ),
        ),
      ],
    );
  }
}
