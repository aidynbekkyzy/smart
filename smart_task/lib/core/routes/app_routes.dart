import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_shell.dart';
import '../../features/items/data/item_model.dart';
import '../../features/items/presentation/item_detail_screen.dart';
import '../../features/items/presentation/item_form_screen.dart';
import '../../features/items/presentation/items_list_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

/// Барлық маршруттар (named routes) бір жерде.
class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const items = '/items'; // arguments: String? category
  static const detail = '/detail'; // arguments: String itemId
  static const form = '/form'; // arguments: Item? (null = жаңа)
  static const settings = '/settings';

  static Route<dynamic> onGenerateRoute(RouteSettings s) {
    final Widget page;
    switch (s.name) {
      case splash:
        page = const SplashScreen();
      case login:
        page = const LoginScreen();
      case register:
        page = const RegisterScreen();
      case home:
        page = const HomeShell();
      case items:
        page = ItemsListScreen(initialCategory: s.arguments as String?);
      case detail:
        page = ItemDetailScreen(itemId: s.arguments as String);
      case form:
        page = ItemFormScreen(item: s.arguments as Item?);
      case settings:
        page = const SettingsScreen();
      default:
        page = const SplashScreen();
    }
    return MaterialPageRoute(builder: (_) => page, settings: s);
  }
}
