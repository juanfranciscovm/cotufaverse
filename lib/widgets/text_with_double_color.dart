import 'package:flutter/material.dart';

class TextWithDoubleColor extends StatelessWidget {
  const TextWithDoubleColor({
    super.key,
    required this.size,
    required this.text1,
    required this.text2,
    this.padding = const EdgeInsets.all(30),
    this.alignment = Alignment.centerLeft,
  });
  final EdgeInsetsGeometry padding;
  final Size size;
  final String text1;
  final String text2;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: size.width,
        child: Align(
          alignment: alignment,
          child: RichText(
            text: TextSpan(
              text: text1,
              style: TextStyle(
                fontFamily: 'Agrandir',
                color: Colors.white,
                fontSize: size.height * 0.04,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: text2,
                  style: TextStyle(
                    fontFamily: 'Agrandir',
                    color: const Color(0xFFF7C53A),
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
