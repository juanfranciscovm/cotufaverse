import 'package:cotufaverse/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CotufaVerse',
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.initialRoute,
    );
  }
}