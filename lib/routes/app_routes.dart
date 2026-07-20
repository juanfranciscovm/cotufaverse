import 'package:cotufaverse/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import "package:cotufaverse/screens/app_screens.dart";

class AppRoutes {
  static const initialRoute = "/navigator";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/navigator": (BuildContext context) => const NavigatorScreen(),
    "/search": (BuildContext context) => const SearchScreen(),
    "/settings": (BuildContext context) => const SettingsScreen(),
    "/profile": (BuildContext context) => const ProfileScreen(),
    "/details": (BuildContext context) => const DetailsScreen(),
    "/about_devs": (BuildContext context) => const AboutDevs(),
    "/favorites_screen": (BuildContext context) => const FavoritesScreen(),
  };
}
