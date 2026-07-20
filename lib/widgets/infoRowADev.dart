import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

Widget infoRowADev({
  required BuildContext context,
  required String text,
  required String imagePath,
  required bool iconOnLeft,
}) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = Image.asset(imagePath, width: 70);

  final textWidget = Expanded(
    child: Text(
      text,
      textAlign: iconOnLeft ? TextAlign.left : TextAlign.right,
      style: GoogleFonts.poppins(
        color: isDarkMode ? Colors.white : Color(0xFF0C123F),
        fontSize: 15,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
    ),
  );

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: iconOnLeft
          ? [icon, const SizedBox(width: 15), textWidget]
          : [textWidget, const SizedBox(width: 15), icon],
    ),
  );
}
