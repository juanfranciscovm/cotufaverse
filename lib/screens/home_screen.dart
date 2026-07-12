import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF232B4D),
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(mediaQuery.size.width * 0.03),
              child: RichText(text: TextSpan(
                text: 'Top Peliculas',
                style: GoogleFonts.poppins(color: Colors.white ,fontSize: mediaQuery.size.height * 0.04, fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: '.',
                    style: GoogleFonts.poppins(color: const Color(0xFFF7C53A), fontSize: mediaQuery.size.height * 0.04 , fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
            
          ],
        ),
      ),
    );
  }
}
