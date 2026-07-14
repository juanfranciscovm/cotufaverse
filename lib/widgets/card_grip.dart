import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CardGrip extends StatefulWidget {
  const CardGrip({super.key});

  @override
  State<CardGrip> createState() => _CardGripState();
}

class _CardGripState extends State<CardGrip> {
  static const double _aspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double maxItemWidth = size.width * 0.35;
    
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        maxCrossAxisExtent: maxItemWidth,
        childAspectRatio: _aspectRatio
      ),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {

        return LayoutBuilder(
          builder: (contex, constrains) {
            return PosterMovieCard(
              itemHeight: constrains.maxHeight,
              index: index,
              itemWidth: constrains.maxWidth,
              padding: const EdgeInsets.all(0),
            );
          }
        );
      },
    );

  }
}
