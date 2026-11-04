import 'package:flutter/material.dart';

import '../../features/items/data/item_model.dart';
import '../routes/app_routes.dart';
import '../state/app_scope.dart';
import '../utils/responsive.dart';
import 'item_card.dart';

/// Тапсырмалар тізімі: телефонда - ListView, планшетте - GridView.
class ItemsView extends StatelessWidget {
  final List<Item> items;
  const ItemsView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    Widget card(Item item) => ItemCard(
          item: item,
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.detail, arguments: item.id),
          onFavorite: () => state.toggleFavorite(item.id),
        );

    return LayoutBuilder(builder: (context, c) {
      final cols = Breakpoints.gridColumns(c.maxWidth);
      if (cols == 1) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 90),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => card(items[i]),
        );
      }
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 90),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisExtent: 100,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => card(items[i]),
      );
    });
  }
}
