import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0C123F),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PreviewSwiper(),
              Padding(
                padding: EdgeInsets.all(size.width * 0.03),
                child: RichText(
                  text: TextSpan(
                    text: 'Top Peliculas',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '.',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFF7C53A),
                          fontSize: size.height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const CardSwiper(),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
