import "package:flutter/material.dart";
import "package:cotufaverse/widgets/widgets.dart";
import "package:cotufaverse/utils/app_dictionary.dart";

class AboutDevs extends StatelessWidget {
  const AboutDevs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Color(0xFF0C123F),
        ),
        title: TextWithDoubleColor(
          size: size,
          text1: AppDictionary.translate(context, "about"),
          text2: AppDictionary.translate(context, "devs"),
          padding: EdgeInsets.zero,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [Color.fromARGB(255, 39, 52, 168), Color(0xFF080B27)]
                : [Colors.white, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                //avatares
                Center(
                  child: SizedBox(
                    height: 220,
                    width: 340,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        //avatar juan
                        Positioned(
                          left: 20,
                          top: 40,
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: isDarkMode
                                      ? Colors.white
                                      : Color(0xFF0C123F),
                                ),
                                ClipPath(
                                  clipper: avatarClipper(),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        right: -14,
                                        top: -19,
                                        child: Image.asset(
                                          "assets/images/avatar_juan.png",
                                          width: 160,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //avatar gabriel
                        Positioned(
                          right: 20,
                          top: 40,
                          child: SizedBox(
                            width: 140,
                            height: 140,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: isDarkMode
                                      ? Colors.white
                                      : Color(0xFF0C123F),
                                ),
                                ClipPath(
                                  clipper: avatarClipper(),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: -14,
                                        top: -20,
                                        child: Image.asset(
                                          "assets/images/avatar_gabriel.png",
                                          width: 160,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //rollo juan
                        Positioned(
                          left: 5,
                          top: 10,
                          child: Image.asset(
                            "assets/images/rollo_juan.png",
                            width: 160,
                          ),
                        ),

                        //rollo gabriel
                        Positioned(
                          right: 5,
                          top: 11,
                          child: Image.asset(
                            "assets/images/rollo_gabriel.png",
                            width: 160,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                infoRowADev(
                  text: AppDictionary.translate(context, "aboutDev1"),
                  imagePath: "assets/images/cotufa_feliz_1.png",
                  iconOnLeft: true,
                ),
                infoRowADev(
                  text: AppDictionary.translate(context, "aboutDev2"),
                  imagePath: "assets/images/cotufa_feliz_2.png",
                  iconOnLeft: false,
                ),
                infoRowADev(
                  text: AppDictionary.translate(context, "aboutDev3"),
                  imagePath: "assets/images/cotufa_feliz_1.png",
                  iconOnLeft: true,
                ),

                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    "assets/images/cotufas_about_dev.png",
                    width: size.width * 0.85,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//clipper para que el excedente de los avatares no se vea
class avatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
    );
    path.addRect(
      Rect.fromLTRB(-150, -150, size.width + 150, size.height * 0.75),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
