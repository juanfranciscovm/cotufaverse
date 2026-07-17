import 'package:cotufaverse/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:cotufaverse/provider/movies_provider.dart";
import 'package:cotufaverse/provider/settings_provider.dart';
import 'package:cotufaverse/themes/app_theme.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      theme: settings.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: "CotufaVerse",
      initialRoute: "/navigator",
      routes: AppRoutes.routes,
    );
  }
}
