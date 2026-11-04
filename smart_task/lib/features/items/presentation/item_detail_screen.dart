import 'package:flutter/material.dart';

import '../../../core/constants/categories.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/primary_button.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemId;
  const ItemDetailScreen({super.key, required this.itemId});

  Future<void> _confirmDelete(BuildContext context) async {
    final state = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Өшіру'),
        content: const Text('Бұл тапсырманы өшіргіңіз келетініне сенімдісіз бе?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Бас тарту')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Өшіру',
                  style: TextStyle(color: AppColors.error))),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      Navigator.pop(context);
      state.deleteItem(itemId);
      messenger
          .showSnackBar(const SnackBar(content: Text('Тапсырма өшірілді')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final item = state.itemById(itemId);
    final theme = Theme.of(context);
    if (item == null) {
      return Scaffold(
          appBar: AppBar(), body: const Center(child: Text('Табылмады')));
    }
    final cat = Categories.of(item.category);
    final secondary = theme.colorScheme.onSurfaceVariant;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Толығырақ'),
        actions: [
          IconButton(
            onPressed: () => state.toggleFavorite(item.id),
            icon: Icon(
              item.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: item.isFavorite ? AppColors.favorite : null,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ResponsiveCenter(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: cat.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(cat.icon, size: 64, color: cat.color),
                ),
                const SizedBox(height: 20),
                Chip(
                  avatar: Icon(cat.icon, size: 16, color: cat.color),
                  label: Text(item.category),
                ),
                const SizedBox(height: 12),
                Text(item.title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 12),
                Row(children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: secondary),
                  const SizedBox(width: 6),
                  Text(formatDate(item.date),
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: secondary)),
                ]),
                const SizedBox(height: 20),
                Text('Сипаттамасы', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(item.description,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
                const SizedBox(height: 32),
                PrimaryButton(
                  label: 'Өңдеу',
                  icon: Icons.edit_outlined,
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.form,
                      arguments: item),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Өшіру',
                  icon: Icons.delete_outline,
                  outlined: true,
                  onPressed: () => _confirmDelete(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
