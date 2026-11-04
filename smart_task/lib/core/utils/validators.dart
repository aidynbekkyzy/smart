/// Форма өрістерін тексеру. null қайтарса - қате жоқ.
class Validators {
  Validators._();

  static String? required(String? value, [String field = 'Бұл өріс']) {
    if (value == null || value.trim().isEmpty) {
      return '$field міндетті түрде толтырылуы керек';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email енгізіңіз';
    final ok = RegExp(r'^[\w.\-+]+@[\w\-]+(\.[\w\-]+)+$').hasMatch(value.trim());
    if (!ok) return 'Email дұрыс емес. Мысалы: name@mail.com';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Құпия сөзді енгізіңіз';
    if (value.length < 6) return 'Құпия сөз кемінде 6 таңбадан тұруы керек';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Құпия сөзді қайталаңыз';
    if (value != original) return 'Құпия сөздер сәйкес келмейді';
    return null;
  }
}
