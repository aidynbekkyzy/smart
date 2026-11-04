import 'package:flutter/widgets.dart';

import 'app_state.dart';

/// AppState-ті виджеттер ағашының кез келген жерінен алуға мүмкіндік береді.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope табылмады');
    return scope!.notifier!;
  }
}
