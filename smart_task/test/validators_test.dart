import 'package:flutter_test/flutter_test.dart';
import 'package:smart_task/core/utils/validators.dart';

void main() {
  test('email validation', () {
    expect(Validators.email(''), isNotNull);
    expect(Validators.email('abc'), isNotNull);
    expect(Validators.email('a@b.kz'), isNull);
  });
  test('password validation', () {
    expect(Validators.password(''), isNotNull);
    expect(Validators.password('123'), isNotNull);
    expect(Validators.password('123456'), isNull);
  });
  test('required validation', () {
    expect(Validators.required('  '), isNotNull);
    expect(Validators.required('x'), isNull);
  });
}
