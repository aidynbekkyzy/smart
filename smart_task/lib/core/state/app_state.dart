import 'package:flutter/material.dart';

import '../../features/auth/data/auth_service.dart';
import '../../features/auth/data/user_model.dart';
import '../../features/items/data/item_model.dart';
import '../../features/items/data/item_service.dart';

/// Қосымшаның жалпы күйі: пайдаланушы, тапсырмалар, баптаулар.
class AppState extends ChangeNotifier {
  final AuthService _auth = AuthService();
  final ItemService _itemService = ItemService();

  User? user;
  ThemeMode themeMode = ThemeMode.light;
  bool notifications = true;

  // ---- Auth ----
  /// Сәтті болса null, қате болса - хабарлама қайтарады.
  String? login(String email, String password) {
    final u = _auth.login(email, password);
    if (u == null) return 'Email немесе құпия сөз қате';
    user = u;
    notifyListeners();
    return null;
  }

  String? register(String name, String email, String password) {
    final u = _auth.register(name, email, password);
    if (u == null) return 'Бұл email бұрын тіркелген';
    user = u;
    notifyListeners();
    return null;
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  // ---- Items ----
  List<Item> get items => _itemService.items;
  List<Item> get favorites => _itemService.favorites;
  Item? itemById(String id) => _itemService.byId(id);
  List<Item> search(String q) => _itemService.search(q);
  String newId() => _itemService.newId();

  void addItem(Item item) {
    _itemService.add(item);
    notifyListeners();
  }

  void updateItem(Item item) {
    _itemService.update(item);
    notifyListeners();
  }

  void deleteItem(String id) {
    _itemService.remove(id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    _itemService.toggleFavorite(id);
    notifyListeners();
  }

  // ---- Settings ----
  void setDarkMode(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setNotifications(bool value) {
    notifications = value;
    notifyListeners();
  }
}
