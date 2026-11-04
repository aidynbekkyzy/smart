import 'package:flutter/material.dart';

import '../../favorites/presentation/favorites_tab.dart';
import '../../profile/presentation/profile_tab.dart';
import '../../search/presentation/search_tab.dart';
import 'home_tab.dart';

/// Bottom NavigationBar бар негізгі қабық: Басты / Іздеу / Таңдаулы / Профиль.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeTab(onSearchTap: () => setState(() => _index = 1)),
          SearchTab(active: _index == 1),
          const FavoritesTab(),
          const ProfileTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Басты'),
          NavigationDestination(
              icon: Icon(Icons.search), label: 'Іздеу'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: 'Таңдаулы'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Профиль'),
        ],
      ),
    );
  }
}
