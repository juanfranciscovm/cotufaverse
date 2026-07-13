import 'package:card_swiper/card_swiper.dart';
import 'package:cotufaverse/widgets/category_label.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewSwiper extends StatefulWidget {
  const PreviewSwiper({super.key});

  @override
  State<PreviewSwiper> createState() => _PreviewSwiperState();
}

class _PreviewSwiperState extends State<PreviewSwiper> {
  static const double _aspectRatio = 4 / 9;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final maxItemHeight = size.height * 0.6;
    final itemWidth = size.width;
    final itemHeight = (itemWidth / _aspectRatio).clamp(0.0, maxItemHeight);

    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: AspectRatio(
        aspectRatio: _aspectRatio,
        child: Swiper(
          autoplayDisableOnInteraction: true,
          autoplay: true,
          autoplayDelay: 30000,
          pagination: const SwiperPagination(),
          control: const SwiperControl(
            color: Colors.white
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                SizedBox.expand(
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(
                      'https://picsum.photos/800/450?random=$index',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.5),
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'El asesinato de Jesse James por el cobarde Robert Ford',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Agrandir',
                          color: Colors.white,
                          fontSize: itemHeight * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '10/10',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: itemHeight * 0.03,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.star,
                            color: const Color(0xFFF7C53A),
                            size: itemHeight * 0.07,
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.eighteen_up_rating_outlined,
                            color: Colors.white,
                            size: itemHeight * 0.07,
                          ),
                        ],
                      ),
                      const SizedBox(),
                      Text(
                        'Consectetur reprehenderit cillum eiusmod culpa eiusmod aute cillum ullamco adipisicing duis do irure. Irure eu quis nulla labore in exercitation ipsum cillum esse sit. Eiusmod ut laboris et adipisicing excepteur non commodo aute. Cillum aliquip nisi in Lorem consequat veniam voluptate sunt sit ut sit. Velit voluptate Lorem do deserunt reprehenderit. Id aute ad duis magna irure nulla. Ex tempor do elit aute commodo occaecat labore non id nulla ut ipsum est qui.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          height: 1.8,
                          color: Colors.white,
                          fontSize: itemHeight * 0.03,
                        ),
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CategoryLabel(
                            itemHeight: itemHeight,
                            category: 'Acción',
                          ),
                          const SizedBox(width: 10),
                          CategoryLabel(
                            itemHeight: itemHeight,
                            category: 'Aventura',
                          ),
                          const SizedBox(width: 10),
                          CategoryLabel(
                            itemHeight: itemHeight,
                            category: 'Misterio',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
