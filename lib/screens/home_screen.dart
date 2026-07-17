import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import "package:cotufaverse/utils/app_dictionary.dart";

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
              // Poner al configurar el usuario, si no borrar
              // TextWithDoubleColor(
              //   size: size,
              //   text1: 'Películas ',
              //   text2: 'Recomendadas',
              // ),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "top_movies"),
                text2: '.',
              ),
              const CardSwiper(),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "popular_movies"),
                text2: '.',
                alignment: Alignment.centerRight,
              ),
              const CardSwiper(),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "upcoming"),
                text2: AppDictionary.translate(context, "upcoming_movies"),
              ),
              const DetailSwiper(),
              TextWithDoubleColor(
                size: size,
                text1: AppDictionary.translate(context, "movie_directory"),
                text2: '.',
                alignment: Alignment.center,
              ),
              OrderByDropdownMenu(),
              const CardGrip(),
              SizedBox(height: size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
