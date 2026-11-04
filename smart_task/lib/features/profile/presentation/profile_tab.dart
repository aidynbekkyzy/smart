import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Future<void> _logout(BuildContext context) async {
    final state = AppScope.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Шығу'),
        content: const Text('Аккаунттан шыққыңыз келе ме?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Жоқ')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Шығу')),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      state.logout();
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final user = state.user;
    final secondary = theme.colorScheme.onSurfaceVariant;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ResponsiveCenter(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.primary,
                child: Text(
                  (user?.name.isNotEmpty ?? false)
                      ? user!.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Center(
                child: Text(user?.name ?? 'Қонақ',
                    style: theme.textTheme.titleLarge)),
            Center(
                child: Text(user?.email ?? '',
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: secondary))),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _Stat(label: 'Тапсырма', value: '${state.items.length}'),
                    _Stat(label: 'Таңдаулы', value: '${state.favorites.length}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: const Text('Менің тапсырмаларым'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.items),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Баптаулар'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.settings),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading:
                        const Icon(Icons.logout, color: AppColors.error),
                    title: const Text('Шығу',
                        style: TextStyle(color: AppColors.error)),
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: [
      Text(value, style: theme.textTheme.headlineMedium),
      Text(label,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
    ]);
  }
}
