import 'package:flutter/material.dart';

class CategoryInfo {
  final String name;
  final IconData icon;
  final Color color;
  const CategoryInfo(this.name, this.icon, this.color);
}

class Categories {
  Categories._();

  static const all = [
    CategoryInfo('Жұмыс', Icons.work_outline, Color(0xFF3F3DBF)),
    CategoryInfo('Оқу', Icons.menu_book_outlined, Color(0xFF0E9F6E)),
    CategoryInfo('Жеке', Icons.person_outline, Color(0xFFE08A00)),
    CategoryInfo('Денсаулық', Icons.favorite_border, Color(0xFFD93F6B)),
  ];

  static List<String> get names => all.map((e) => e.name).toList();

  static CategoryInfo of(String name) =>
      all.firstWhere((c) => c.name == name, orElse: () => all.first);
}
