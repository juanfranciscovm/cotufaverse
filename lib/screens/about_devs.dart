import "package:flutter/material.dart";
import "package:cotufaverse/widgets/widgets.dart";
import "package:cotufaverse/utils/app_dictionary.dart";

class AboutDevs extends StatelessWidget {
  const AboutDevs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TextWithDoubleColor(
          size: size,
          text1: "Sobre los ",
          text2: "devs",
          padding: EdgeInsets.zero,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 39, 52, 168), Color(0xFF080B27)],
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
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      //avatar juan
                      Positioned(
                        right: (size.width / 2) + 9,
                        top: 40,
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
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
                        left: (size.width / 2) + 9,
                        top: 40,
                        child: SizedBox(
                          width: 140,
                          height: 140,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
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
                        left: (size.width / 2) - 160,
                        top: 10,
                        child: Image.asset(
                          "assets/images/rollo_juan.png",
                          width: 160,
                        ),
                      ),

                      //rollo gabriel
                      Positioned(
                        right: (size.width / 2) - 160,
                        top: 11,
                        child: Image.asset(
                          "assets/images/rollo_gabriel.png",
                          width: 160,
                        ),
                      ),
                    ],
                  ),
                ),

                infoRowADev(
                  text:
                      "Estudiantes de Ingeniería de Sistemas en la Universidad de Margarita.",
                  imagePath: "assets/images/cotufa_feliz_1.png",
                  iconOnLeft: true,
                ),
                infoRowADev(
                  text: "Nos fascinan las películas y series.",
                  imagePath: "assets/images/cotufa_feliz_2.png",
                  iconOnLeft: false,
                ),
                infoRowADev(
                  text:
                      "CotufaVerse está elaborada en flutter y dart para la materia de Programación III.",
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
