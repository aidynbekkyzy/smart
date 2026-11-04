import 'user_model.dart';

class _Account {
  final User user;
  final String password;
  _Account(this.user, this.password);
}

/// Жергілікті (in-memory) авторизация сервисі.
/// Демо аккаунт: demo@mail.com / 123456
class AuthService {
  final Map<String, _Account> _accounts = {
    'demo@mail.com': _Account(
        const User(name: 'Айгерім Нұрлан', email: 'demo@mail.com'), '123456'),
  };

  User? login(String email, String password) {
    final acc = _accounts[email.trim().toLowerCase()];
    if (acc == null || acc.password != password) return null;
    return acc.user;
  }

  /// Email бос болмаса - тіркеледі, әйтпесе null қайтарады.
  User? register(String name, String email, String password) {
    final key = email.trim().toLowerCase();
    if (_accounts.containsKey(key)) return null;
    final user = User(name: name.trim(), email: key);
    _accounts[key] = _Account(user, password);
    return user;
  }
}
