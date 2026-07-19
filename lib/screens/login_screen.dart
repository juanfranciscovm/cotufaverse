import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: TextButton(
          onPressed: () {
            login(moviesProvider);
          },
          child: Text('Login'),
        ),
      ),
    );
  }

  void showError() {
    final snackBar = const SnackBar(
      content: Text('Error al iniciar sesion'),
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
