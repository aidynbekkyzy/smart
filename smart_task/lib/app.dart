import 'package:flutter/material.dart';

import 'core/routes/app_routes.dart';
import 'core/state/app_scope.dart';
import 'core/state/app_state.dart';
import 'core/theme/app_theme.dart';

class SmartTaskApp extends StatefulWidget {
  const SmartTaskApp({super.key});

  @override
  State<SmartTaskApp> createState() => _SmartTaskAppState();
}

class _SmartTaskAppState extends State<SmartTaskApp> {
  final AppState _state = AppState();

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: _state,
      child: ListenableBuilder(
        listenable: _state,
        builder: (context, _) => MaterialApp(
          title: 'SmartTask',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _state.themeMode,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        ),
      ),
    );
  }
}
