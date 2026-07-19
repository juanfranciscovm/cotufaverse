import 'package:cotufaverse/provider/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:cotufaverse/screens/app_screens.dart';
import 'package:cotufaverse/widgets/widgets.dart';
import 'package:provider/provider.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final MoviesProvider moviesProvider = Provider.of(context);
    final List<Widget> screens = [
      HomeScreen(moviesProvider: moviesProvider,),
      const SearchScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(233, 40, 56, 178),
                    Color.fromARGB(233, 12, 18, 63),
                  ],
                )
              : null,
          color: isDarkMode ? null : Colors.white,
        ),

        child: IndexedStack(index: _currentIndex, children: screens),
      ),

      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
