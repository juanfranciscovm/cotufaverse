import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double minNavBarHeight = 60;
    final size = MediaQuery.of(context).size;
    final double navBarHeight = (size.height * 0.10).clamp(minNavBarHeight, double.infinity);
    final double iconSize = navBarHeight * 0.35;
    final double textSize = navBarHeight * 0.2;

    return CurvedNavigationBar(
      index: currentIndex,
      height: navBarHeight,
      backgroundColor: Colors.transparent,
      color: const Color.fromARGB(255, 8, 11, 39),
      buttonBackgroundColor: const Color(0xFFF7C53A),
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.easeInOut,

      items: [
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 0
                ? Icons.local_movies_rounded
                : Icons.local_movies_outlined,
            color: Colors.white,
            size: iconSize,
          ),
          label: 'Home',
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 1 ? Icons.search : Icons.search,
            color: Colors.white,
            size: iconSize,
          ),
          label: 'Buscar',
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 4
                ? Icons.account_circle_rounded
                : Icons.account_circle_outlined,
            color: Colors.white,
            size: iconSize,
          ),
          label: 'Perfil',
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 3 ? Icons.settings : Icons.settings,
            color: Colors.white,
            size: iconSize,
          ),
          label: 'Config',
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: textSize,
          ),
        ),
      ],
      onTap: onTap,
    );
  }
}
