import 'package:flutter/material.dart';

import '../../../core/constants/categories.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/items_view.dart';

class ItemsListScreen extends StatefulWidget {
  final String? initialCategory;
  const ItemsListScreen({super.key, this.initialCategory});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  String? _category;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final items = _category == null
        ? state.items
        : state.items.where((e) => e.category == _category).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Тапсырмалар')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.form),
        child: const Icon(Icons.add),
      ),
      body: ResponsiveCenter(
        maxWidth: 1100,
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                children: [
                  _chip('Барлығы', _category == null, () {
                    setState(() => _category = null);
                  }),
                  for (final n in Categories.names)
                    _chip(n, _category == n, () {
                      setState(() => _category = n);
                    }),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const EmptyState(
                      icon: Icons.inbox_outlined,
                      message: 'Бұл санатта тапсырма жоқ')
                  : ItemsView(items: items),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: (_) => onTap(),
        ),
      );
}
