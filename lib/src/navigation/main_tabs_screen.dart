import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class MainTabsScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainTabsScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: (index) =>
            navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Информация'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Магазины'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
