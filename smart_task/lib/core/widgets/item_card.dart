import 'package:flutter/material.dart';

import '../../features/items/data/item_model.dart';
import '../constants/categories.dart';
import '../theme/app_colors.dart';
import '../utils/formatters.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const ItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final cat = Categories.of(item.category);
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.onSurfaceVariant;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: cat.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(cat.icon, color: cat.color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: secondary)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 12, color: secondary),
                      const SizedBox(width: 4),
                      Text(formatDate(item.date),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: secondary)),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(item.category,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: cat.color,
                                fontWeight: FontWeight.w600)),
                      ),
                    ]),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavorite,
                icon: Icon(
                  item.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavorite ? AppColors.favorite : secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
