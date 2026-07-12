import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return CurvedNavigationBar(
      index: currentIndex,
      height: mediaQuery.size.height * 0.10,
      backgroundColor: const Color(0xFF232B4D),
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
            size: mediaQuery.size.height * 0.035,
          ),
          label: 'Home',
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: mediaQuery.size.height * 0.02,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 1 ? Icons.search : Icons.search,
            color: Colors.white,
            size: mediaQuery.size.height * 0.035 ,
          ),
          label: 'Buscar',
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: mediaQuery.size.height * 0.02,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 4
                ? Icons.account_circle_rounded
                : Icons.account_circle_outlined,
            color: Colors.white,
            size: mediaQuery.size.height * 0.035 ,
          ),
          label: 'Perfil',
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: mediaQuery.size.height * 0.02,
          ),
        ),
        CurvedNavigationBarItem(
          child: Icon(
            currentIndex == 3 ? Icons.settings : Icons.settings,
            color: Colors.white,
            size: mediaQuery.size.height * 0.035 ,
          ),
          label: 'Configuración',
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: mediaQuery.size.height * 0.02,
          ),
        ),
      ],
      onTap: onTap,
    );
  }
}
