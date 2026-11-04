import 'package:flutter/material.dart';

import '../../../core/state/app_scope.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/items_view.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = AppScope.of(context).favorites;
    return Scaffold(
      appBar: AppBar(title: const Text('Таңдаулылар')),
      body: ResponsiveCenter(
        maxWidth: 1100,
        child: favorites.isEmpty
            ? const EmptyState(
                icon: Icons.favorite_border,
                message:
                    'Таңдаулы тапсырмалар жоқ.\nЖүрекше белгісін басып қосыңыз')
            : ItemsView(items: favorites),
      ),
    );
  }
}
