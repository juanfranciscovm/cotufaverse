import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        size: size,
        searchButtonAction: () {},
        menuButtonAction: () {},
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PreviewSwiper(),
              TextWithDoubleColor(
                size: size,
                text1: 'Top Películas',
                text2: '.',
              ),
              const CardSwiper(),
              TextWithDoubleColor(
                size: size,
                text1: 'Películas Populares',
                text2: '.',
              ),
              SizedBox(height: size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
