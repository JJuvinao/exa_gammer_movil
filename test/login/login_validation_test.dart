import 'package:flutter_test/flutter_test.dart';

import 'login_validators.dart';

void main() {
  group('Validación de Usuario', () {
    test('Usuario vacío', () {
      final result = LoginValidators.validarUsuario('');
      expect(result, 'El nombre de usuario no puede estar vacío');
    });

    test('Usuario con menos de 10 caracteres', () {
      final result = LoginValidators.validarUsuario('abc123');
      expect(result, 'El usuario debe tener al menos 10 caracteres');
    });

    test('Usuario con más de 40 caracteres', () {
      final result = LoginValidators.validarUsuario('a' * 41);
      expect(result, 'El usuario no puede superar los 40 caracteres');
    });

    test('Usuario válido', () {
      final result = LoginValidators.validarUsuario('usuarioCorrecto123');
      expect(result, null);
    });
  });

  group('Validación de Contraseña', () {
    test('Contraseña vacía', () {
      final result = LoginValidators.validarPassword('');
      expect(result, 'La contraseña no puede estar vacía');
    });

    test('Contraseña con menos de 8 caracteres', () {
      final result = LoginValidators.validarPassword('12345');
      expect(result, 'La contraseña debe tener mínimo 8 caracteres');
    });

    test('Contraseña válida', () {
      final result = LoginValidators.validarPassword('Abcde123!');
      expect(result, null);
    });
  });
}
