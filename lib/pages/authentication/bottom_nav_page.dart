import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(
      child: Text('home'),
    ),
    const Center(
      child: Text('Topis'),
    ),
    const Center(
      child: Text('username'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        animationDuration: const Duration(seconds: 2),
        // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_filled),
            label: 'home',
          ),
          NavigationDestination(
              icon: Icon(Icons.category),
              selectedIcon: Icon(Icons.category_rounded),
              label: 'Topics'),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_rounded),
            label: 'user',
          ),
        ],
      ),
    );
  }
}
