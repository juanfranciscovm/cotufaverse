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
      child: SizedBox(
        height: preferredSize.height,
        width: preferredSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: preferredSize.height * 0.8,
                width: preferredSize.height * 0.8,
                child: IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black38,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  icon: const Icon(Icons.menu),
                  onPressed: menuButtonAction,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: preferredSize.height * 0.8,
                width: preferredSize.height * 0.8,
                child: IconButton(
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black38,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  icon: const Icon(Icons.search),
                  onPressed: searchButtonAction,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((size.height * 0.08).clamp(_minAppBarHeight, double.infinity));
}
