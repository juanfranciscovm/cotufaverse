import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: itemHeight * 0.065,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '10/10',
                      style: GoogleFonts.poppins(
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
        Positioned(
          top: 10,
          right: 10,
          child: Icon(
            Icons.eighteen_up_rating_outlined,
            color: Colors.white,
            size: itemHeight * 0.125,
          ),
        ),
      ],
    );
  }
}
