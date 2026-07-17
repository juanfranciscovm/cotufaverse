import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";
import "package:google_fonts/google_fonts.dart";

class PosterAndTitle extends StatelessWidget {
  final Movie movie;

  const PosterAndTitle({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FadeInImage(
              placeholder: const AssetImage("assets/images/loading.gif"),
              image: NetworkImage(movie.fullPosterPath),
              height: 200,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: 130,
                  color: const Color.fromARGB(25, 255, 255, 255),
                  child: const Icon(
                    Icons.movie,
                    color: Color.fromARGB(133, 255, 255, 255),
                    size: 50,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontFamily: "Agrandir",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 248, 240, 204),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  movie.originalTitle,
                  style: GoogleFonts.poppins(
                    color: Color.fromARGB(179, 255, 255, 255),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rate_rounded,
                      color: Color.fromARGB(255, 255, 197, 39),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${movie.voteAverage.round()}/10",
                      style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 248, 240, 204),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
