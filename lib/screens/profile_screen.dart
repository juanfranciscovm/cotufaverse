import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:cotufaverse/screens/app_screens.dart';
import "package:cotufaverse/utils/app_dictionary.dart";

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = context.watch<MoviesProvider>();
    if (moviesProvider.login) {
      return LoggedProfileScreen(
        onLogoutComplete: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppDictionary.translate(context, "logout_successful"),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    } else {
      return LoginScreen(
        onLoginComplete: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppDictionary.translate(context, "login_successful"),
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    }
  }
}
