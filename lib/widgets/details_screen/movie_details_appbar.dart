import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";

class MovieDetailsAppbar extends StatelessWidget {
  final Movie movie;

  const MovieDetailsAppbar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 12, 18, 63),
      foregroundColor: const Color.fromARGB(255, 255, 197, 39),
      expandedHeight: 150,
      centerTitle: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: const Color.fromARGB(106, 0, 0, 0),
          child: Text(
            movie.title,
            style: const TextStyle(
              fontFamily: "Agrandir",
              fontSize: 16,
              color: Color.fromARGB(255, 248, 240, 204),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage("assets/images/loading.gif"),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) {
            return Container(color: const Color(0xFF0C123F));
          },
        ),
      ),
    );
  }
}
