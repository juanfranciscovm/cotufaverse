import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavBar({Key? key, required this.currentIndex, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 75,
      backgroundColor: Colors.transparent,
      color: const Color.fromARGB(255, 52, 83, 121),
      buttonBackgroundColor: Colors.blueAccent,
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.easeInOut,

      items: [
        Icon(
          currentIndex == 0
              ? Icons.local_movies_rounded
              : Icons.local_movies_outlined,
          color: Colors.white,
          size: 25,
        ),
        Icon(
          currentIndex == 1 ? Icons.star : Icons.star_border_outlined,
          color: Colors.white,
          size: 25,
        ),
        Icon(
          currentIndex == 2 ? Icons.history : Icons.history,
          color: Colors.white,
          size: 25,
        ),
        Icon(
          currentIndex == 3 ? Icons.settings : Icons.settings,
          color: Colors.white,
          size: 25,
        ),
        Icon(
          currentIndex == 4
              ? Icons.account_circle_rounded
              : Icons.account_circle_outlined,
          color: Colors.white,
          size: 25,
        ),
      ],
      onTap: onTap,
    );
  }
}
