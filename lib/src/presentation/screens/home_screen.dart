import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/presentation/screens/character_list_screen.dart';
import 'package:rick_and_morty/src/presentation/screens/favorites_screen.dart';

import '../../../core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isDarkTheme = false;
  final List<Widget> _screens = [
    const CharacterListScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkTheme ? darkTheme() : lightTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rick & Morty Portal',
            style: TextStyle(
              fontFamily: 'GetSchwifty', // Quirky Rick and Morty font
              fontSize: 28,
              color: Color(0xFF00FFAA), // Portal Green
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder:
                    (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                child: IconButton(
                  key: ValueKey(_isDarkTheme),
                  icon: Icon(
                    _isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round,
                    color:
                        _isDarkTheme
                            ? const Color(0xFFFFD700) // Morty Yellow
                            : const Color(0xFF16213E), // Nebula Blue
                    size: 28,
                  ),
                  onPressed: () => setState(() => _isDarkTheme = !_isDarkTheme),
                  tooltip: _isDarkTheme ? 'Light Mode' : 'Dark Mode',
                ),
              ),
            ),
          ],
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt),
              // Characters as people
              activeIcon: Icon(Icons.people_alt, color: Color(0xFF00FFAA)),
              // Portal Green when active
              label: 'Characters',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              activeIcon: Icon(Icons.star, color: Color(0xFFFFD700)),
              // Morty Yellow when active
              label: 'Favorites',
            ),
          ],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
