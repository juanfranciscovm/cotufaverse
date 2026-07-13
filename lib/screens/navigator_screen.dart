import 'package:flutter/material.dart';
import 'package:cotufaverse/screens/app_screens.dart';
import 'package:cotufaverse/widgets/widgets.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorState();
}

class _NavigatorState extends State<NavigatorScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(233, 12, 18, 63),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(233, 40, 56, 178),
              Color.fromARGB(233, 12, 18, 63),
            ],
          ),
        ),

        child: IndexedStack(index: _currentIndex, children: _screens),
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
