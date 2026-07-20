import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:cotufaverse/themes/app_theme.dart";
import "package:cotufaverse/utils/app_dictionary.dart";

class LoggedProfileScreen extends StatelessWidget {
  final VoidCallback onLogoutComplete;
  const LoggedProfileScreen({super.key, required this.onLogoutComplete});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final account = moviesProvider.account;

    final String displayName = (account != null && account.name.isNotEmpty)
        ? account.name
        : (account?.username ??
              AppDictionary.translate(context, "movie_lover"));

    String? avatarUrl;
    if (account?.avatarPath != null) {
      avatarUrl = "https://image.tmdb.org/t/p/w500${account!.avatarPath}";
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: size.height * 0.1,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextWithDoubleColor(
          size: size,
          text1: AppDictionary.translate(context, "profile"),
          text2: ".",
          padding: const EdgeInsets.all(20.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //profile pic
                        Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child: avatarUrl != null
                                ? FadeInImage(
                                    placeholder: const AssetImage(
                                      "assets/images/loading.gif",
                                    ),
                                    image: NetworkImage(avatarUrl),
                                    fit: BoxFit.cover,
                                    imageErrorBuilder: (_, _, _) => const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.grey,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        //nombre
                        Text(
                          AppDictionary.translate(context, "welcome") +
                              ", $displayName",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "AgrandirWide",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 30),
                        Image.asset(
                          "assets/images/favorite_icon.png",
                          height: 120,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 15),
                        //botón fav
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/about_devs");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFC527),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              AppDictionary.translate(context, "see_favorites"),
                              style: TextStyle(
                                fontFamily: "AgrandirWide",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF080B27),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //botón cerrar sesión
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        moviesProvider.logOut();
                        onLogoutComplete();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC527),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        AppDictionary.translate(context, "logout"),
                        style: TextStyle(
                          fontFamily: "AgrandirWide",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF080B27),
                        ),
                      ),
                    ),
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
