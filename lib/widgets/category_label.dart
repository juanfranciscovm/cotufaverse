import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        category,
        style: TextStyle(color: Colors.white, fontSize: itemHeight * 0.04),
      ),
    );
  }
}
