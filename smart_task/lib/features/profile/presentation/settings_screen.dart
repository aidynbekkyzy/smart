import 'package:flutter/material.dart';

import '../../../core/state/app_scope.dart';
import '../../../core/utils/responsive.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Баптаулар')),
      body: ResponsiveCenter(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode_outlined),
                    title: const Text('Қараңғы тақырып'),
                    value: state.themeMode == ThemeMode.dark,
                    onChanged: state.setDarkMode,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined),
                    title: const Text('Хабарландырулар'),
                    value: state.notifications,
                    onChanged: state.setNotifications,
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.language),
                    title: Text('Тіл'),
                    trailing: Text('Қазақша'),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('Қосымша нұсқасы'),
                    trailing: Text('1.0.0'),
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
