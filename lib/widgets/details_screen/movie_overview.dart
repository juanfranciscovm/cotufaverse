import "package:flutter/material.dart";
import "package:cotufaverse/models/models.dart";
import "package:google_fonts/google_fonts.dart";

class MovieOverview extends StatelessWidget {
  final Movie movie;

  const MovieOverview({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDark
        ? const Color(0xFFF8F0CC)
        : const Color(0xFF0C123F);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: GoogleFonts.poppins(color: textColor, fontSize: 15, height: 1.3),
      ),
    );
  }
}
