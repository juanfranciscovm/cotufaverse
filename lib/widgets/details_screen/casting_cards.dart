import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:cotufaverse/models/models.dart";
import "package:cotufaverse/provider/movies_provider.dart";

class CastingCards extends StatelessWidget {
  final Movie movie;

  const CastingCards({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movie.id),
      builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 260,
            child: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 197, 39),
              ),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 260,
          child: ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return CastCard(actor: snapshot.data![index]);
            },
          ),
        );
      },
    );
  }
}

class CastCard extends StatelessWidget {
  final Cast actor;

  const CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 260,
      width: 130,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              actor.fullProfilePath,
              height: 165,
              width: 130,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  width: 130,
                  color: const Color.fromARGB(26, 255, 255, 255),
                  child: const Icon(
                    Icons.person,
                    color: Color.fromARGB(128, 255, 255, 255),
                    size: 50,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.character ?? "Desconocido",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color.fromARGB(255, 248, 240, 204),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Text(
            actor.name,
            style: GoogleFonts.poppins(
              color: Color.fromARGB(172, 255, 255, 255),
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
