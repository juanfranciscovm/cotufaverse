import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesProvider moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: TextButton(
          onPressed: () {
            moviesProvider.logOut();
          },
          child: Text('Log out'),
        ),
      ),
    );
  }
}
