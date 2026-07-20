import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:cotufaverse/themes/app_theme.dart";
import "package:cotufaverse/widgets/widgets.dart";
import "package:cotufaverse/utils/app_dictionary.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginComplete});

  final VoidCallback onLoginComplete;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? token;

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  void _initDeepLinks() {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      if (uri.scheme == 'cotufaverse' && uri.host == 'callback') {
        _completeAutentication();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color color = isDarkMode ? Colors.white : const Color(0xFF080B27);
    final size = MediaQuery.of(context).size;
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(
      context,
      listen: false,
    );

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
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/login_icon.png",
                              height: size.height * 0.30,
                              fit: BoxFit.contain,
                            ),

                            const SizedBox(height: 40),
                            Text(
                              AppDictionary.translate(context, "login_text"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "AgrandirWide",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: color,
                                height: 1.3,
                              ),
                            ),

                            const SizedBox(height: 50),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                onPressed: () => login(moviesProvider),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFC527),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  AppDictionary.translate(context, "login"),
                                  style: TextStyle(
                                    fontFamily: "AgrandirWide",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF080B27),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showError() {
    final snackBar = SnackBar(
      content: Text(AppDictionary.translate(context, "login_error")),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future login(MoviesProvider moviesProvider) async {
    bool browseLaunched = false;
    token = await moviesProvider.getRequestToken();

    if (token == null) return false;

    browseLaunched = await moviesProvider.authorizeToken(token!);

    if (!browseLaunched) {
      showError();
    }
  }

  void _completeAutentication() async {
    bool result;
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(
      context,
      listen: false,
    );

    if (token == null) return;

    result = await moviesProvider.createSession(token!);

    if (result) {
      widget.onLoginComplete();
      return;
    }
    showError();
  }
}
