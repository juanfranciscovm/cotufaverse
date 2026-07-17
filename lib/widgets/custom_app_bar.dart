import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double _minAppBarHeight = 60;
  final Size size;
  final VoidCallback searchButtonAction;
  final VoidCallback menuButtonAction;

  const CustomAppBar({
    super.key,
    required this.size,
    required this.searchButtonAction,
    required this.menuButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: false,
      left: false,
      child: SizedBox(
        height: preferredSize.height,
        width: preferredSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonAppbar(
              preferredSize: preferredSize,
              onPress: menuButtonAction,
              icon: Icons.menu,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
              color: Colors.black26),
              width: (size.width *0.4).clamp(0, 200),
              child: Image.asset('assets/images/logoCotufaVerse.png')),
            ButtonAppbar(
              preferredSize: preferredSize,
              onPress: searchButtonAction,
              icon: Icons.search,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    (size.height * 0.08).clamp(_minAppBarHeight, double.infinity),
  );
}

class ButtonAppbar extends StatelessWidget {
  const ButtonAppbar({
    super.key,
    required this.preferredSize,
    required this.onPress,
    required this.icon,
  });

  final Size preferredSize;
  final VoidCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: preferredSize.height * 0.8,
        width: preferredSize.height * 0.8,
        child: IconButton(
          style: IconButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black38,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          icon: Icon(icon),
          onPressed: onPress,
        ),
      ),
    );
  }
}
