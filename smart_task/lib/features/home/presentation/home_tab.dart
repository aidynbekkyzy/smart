import 'package:flutter/material.dart';

import '../../../core/constants/categories.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/item_card.dart';
import '../../../core/widgets/section_header.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onSearchTap;
  const HomeTab({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    final name = state.user?.name.split(' ').first ?? 'Қонақ';
    final recent = state.items.take(3).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.form),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: ResponsiveCenter(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Сәлем,',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: secondary)),
                        Text(name, style: theme.textTheme.headlineMedium),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary,
                    child: Text(name.isEmpty ? '?' : name[0].toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: onSearchTap,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: theme.colorScheme.outlineVariant),
                  ),
                  child: Row(children: [
                    Icon(Icons.search, color: secondary),
                    const SizedBox(width: 10),
                    Text('Тапсырма іздеу...',
                        style: TextStyle(color: secondary)),
                  ]),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _StatCard(
                      label: 'Барлығы',
                      value: '${state.items.length}',
                      icon: Icons.list_alt,
                      color: AppColors.primary),
                  const SizedBox(width: 12),
                  _StatCard(
                      label: 'Таңдаулы',
                      value: '${state.favorites.length}',
                      icon: Icons.favorite,
                      color: AppColors.favorite),
                  const SizedBox(width: 12),
                  _StatCard(
                      label: 'Санат',
                      value: '${Categories.all.length}',
                      icon: Icons.category_outlined,
                      color: AppColors.success),
                ],
              ),
              const SizedBox(height: 24),
              Text('Санаттар', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: Categories.all.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) {
                    final c = Categories.all[i];
                    return ActionChip(
                      avatar: Icon(c.icon, size: 18, color: c.color),
                      label: Text(c.name),
                      onPressed: () => Navigator.pushNamed(
                          context, AppRoutes.items,
                          arguments: c.name),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SectionHeader(
                title: 'Соңғы тапсырмалар',
                actionLabel: 'Барлығы',
                onAction: () => Navigator.pushNamed(context, AppRoutes.items),
              ),
              const SizedBox(height: 8),
              for (final item in recent) ...[
                ItemCard(
                  item: item,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.detail,
                      arguments: item.id),
                  onFavorite: () => state.toggleFavorite(item.id),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard(
      {required this.label,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 10),
              Text(value, style: theme.textTheme.titleLarge),
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}
