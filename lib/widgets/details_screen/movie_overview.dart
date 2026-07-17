import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";
import "package:google_fonts/google_fonts.dart";

class MovieOverview extends StatelessWidget {
  final Movie movie;

  const MovieOverview({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: GoogleFonts.poppins(
          color: Color.fromARGB(255, 248, 240, 204),
          fontSize: 15,
          height: 1.3,
        ),
      ),
    );
  }
}
