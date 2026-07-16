import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryLabel extends StatelessWidget {
  const CategoryLabel({
    super.key,
    required this.itemHeight,
    required this.category,
  });

  final double itemHeight;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        category,
        style: GoogleFonts.poppins(
          color: Colors.white, fontSize: itemHeight * 0.025),
      ),
    );
  }
}
