import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSwiper extends StatefulWidget {
  const DetailSwiper({super.key});

  @override
  State<DetailSwiper> createState() => _DetailSwiperState();
}

class _DetailSwiperState extends State<DetailSwiper> {
  static const double _aspectRatioCard = 3 / 2;
  static const double _aspectRatioImage = 2 / 3;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double maxItemWidth = size.width;
    final double maxcardHeight = size.height * 0.6;
    final double cardWidth = (maxcardHeight * _aspectRatioCard).clamp(
      0.0,
      maxItemWidth,
    );

    final double cardHeight = cardWidth / _aspectRatioCard;

    final double imageWidth = cardHeight * _aspectRatioImage;

    return SizedBox(
      width: size.width,
      height: cardHeight,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsGeometry.all(8),
            child: Container(
              clipBehavior: Clip.antiAlias,
              height: cardHeight,
              width: cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: cardHeight,
                    width: imageWidth,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage(
                        'assets/images/loading.gif',
                      ),
                      image: NetworkImage(
                        'https://picsum.photos/450/800?random=$index',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        SizedBox.expand(
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage(
                              'assets/images/loading.gif',
                            ),
                            image: NetworkImage(
                              'https://picsum.photos/800/450?random=$index',
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black54, Colors.black],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'El asesinato de Jesse James por el cobarde Robert Ford',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: cardHeight * 0.045,
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
                                      fontSize: cardHeight * 0.03,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xFFF7C53A),
                                    size: cardHeight * 0.07,
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.eighteen_up_rating_outlined,
                                    color: Colors.white,
                                    size: cardHeight * 0.07,
                                  ),
                                ],
                              ),
                              const SizedBox(),
                              Text(
                                'Consectetur reprehenderit cillum eiusmod culpa eiusmod aute cillum ullamco adipisicing duis do irure. Irure eu quis nulla labore in exercitation ipsum cillum esse sit. Eiusmod ut laboris et adipisicing excepteur non commodo aute. Cillum aliquip nisi in Lorem consequat veniam voluptate sunt sit ut sit. Velit voluptate Lorem do deserunt reprehenderit. Id aute ad duis magna irure nulla. Ex tempor do elit aute commodo occaecat labore non id nulla ut ipsum est qui.',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  height: 1.8,
                                  color: Colors.white,
                                  fontSize: cardHeight * 0.03,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: cardHeight * 0.125,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: CategoryLabel(
                                        itemHeight: cardHeight,
                                        category: 'Acción',
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
