import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterTag extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const FilterTag({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromARGB(255, 255, 197, 39)
              : const Color.fromARGB(255, 12, 18, 63),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isActive
                ? const Color.fromARGB(255, 12, 18, 63)
                : const Color.fromARGB(255, 255, 197, 39),
          ),
        ),
      ),
    );
  }
}
