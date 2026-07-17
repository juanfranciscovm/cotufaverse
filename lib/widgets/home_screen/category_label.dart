import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryLabel extends StatelessWidget {
  const CategoryLabel({super.key, this.itemHeight, required this.category});

  final double? itemHeight;
  final String category;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color itemColor = isDark ? Colors.white : const Color(0xFF0C123F);
    final double fontSize = itemHeight != null ? (itemHeight! * 0.025) : 14;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: itemColor, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        category,
        style: GoogleFonts.poppins(color: itemColor, fontSize: fontSize),
      ),
    );
  }
}
