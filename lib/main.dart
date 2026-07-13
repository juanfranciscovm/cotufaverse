import 'package:cotufaverse/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:cotufaverse/provider/movies_provider.dart";

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CotufaVerse",
      initialRoute: "/navigator",
      routes: AppRoutes.routes,
    );
  }
}
