import 'package:flutter/material.dart';
import "package:cotufaverse/screens/app_screens.dart";

class AppRoutes {
  static const initialRoute = "/navigator";

  static Map<String, Widget Function(BuildContext)> routes = {
    "/navigator": (BuildContext context) => const NavigatorScreen(),
    "/home": (BuildContext context) => const HomeScreen(),
    "/search": (BuildContext context) => const SearchScreen(),
    "/settings": (BuildContext context) => const SettingsScreen(),
    "/profile": (BuildContext context) => const ProfileScreen(),
    "/details": (BuildContext context) => const DetailsScreen(),
  };
}
