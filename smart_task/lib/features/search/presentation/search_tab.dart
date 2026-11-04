import 'package:flutter/material.dart';

import '../../../core/state/app_scope.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/items_view.dart';

class SearchTab extends StatefulWidget {
  final bool active;
  const SearchTab({super.key, this.active = false});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final results = state.search(_query);

    return Scaffold(
      appBar: AppBar(title: const Text('Іздеу')),
      body: ResponsiveCenter(
        maxWidth: 1100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: AppTextField(
                controller: _controller,
                label: 'Тапсырма атауы, сипаттамасы немесе санаты',
                hint: 'Іздеу...',
                icon: Icons.search,
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: _query.trim().isEmpty
                  ? const EmptyState(
                      icon: Icons.search,
                      message: 'Іздеу үшін сөз енгізіңіз')
                  : results.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off,
                          message: 'Ештеңе табылмады')
                      : ItemsView(items: results),
            ),
          ],
        ),
      ),
    );
  }
}
