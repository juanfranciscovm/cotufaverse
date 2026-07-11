import 'package:flutter/material.dart';
import "package:cotufaverse/screens/app_screens.dart";

class AppRoutes {
  static const initialRoute = "/navigator";

  static Map<String, Widget Function(BuildContext)> routes = {
  "/navigator": (BuildContext context) => const NavigatorScreen(),
  };
}
