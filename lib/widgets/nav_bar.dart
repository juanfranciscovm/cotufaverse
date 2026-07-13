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
    final size = MediaQuery.of(context).size;

    return CurvedNavigationBar(
      index: currentIndex,
      height: size.height * 0.10,
      backgroundColor: const Color(0xFF0C123F),
      color: Colors.black38,
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
            size: size.height * 0.035,
          ),
          label: 'Home',
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: size.height * 0.02,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 1 ? Icons.search : Icons.search,
            color: Colors.white,
            size: size.height * 0.035 ,
          ),
          label: 'Buscar',
          labelStyle: GoogleFonts.poppins( 
            color: Colors.white,
            fontSize: size.height * 0.02,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 4
                ? Icons.account_circle_rounded
                : Icons.account_circle_outlined,
            color: Colors.white,
            size: size.height * 0.035 ,
          ),
          label: 'Perfil',
          labelStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: size.height * 0.02,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 3 ? Icons.settings : Icons.settings,
            color: Colors.white,
            size: size.height * 0.035 ,
          ),
          label: 'Config',
          labelStyle: GoogleFonts.poppins(  
            color: Colors.white,
            fontSize: size.height * 0.02,
          ),
        ),
      ],
      onTap: onTap,
    );
  }
}
