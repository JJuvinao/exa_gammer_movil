import 'package:flutter_test/flutter_test.dart';
import 'validaciones_clase.dart';

void main() {
  group('Lógica AgregarClase', () {
    group('Validación de Tema', () {
      test('Tema válido con 5 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Tema1',
          5,
          20,
          'Tema',
        );
        expect(resultado, isNull);
      });

      test('Tema válido con 12 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Tema General',
          5,
          20,
          'Tema',
        );
        expect(resultado, isNull);
      });

      test('Tema válido con 20 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Tema de Matemáticas',
          5,
          20,
          'Tema',
        );
        expect(resultado, isNull);
      });

      test('Tema inválido con 3 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Mat',
          5,
          20,
          'Tema',
        );
        expect(resultado, isNotNull);
      });

      test('Tema inválido con 4 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Tema',
          5,
          20,
          'Tema',
        );
        expect(resultado, isNotNull);
      });

      test('Tema inválido con más de 20 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Tema de Matemáticas Avanzadas',
          5,
          20,
          'Tema',
        );
        expect(resultado, isNotNull);
      });

      test('Tema null', () {
        String? resultado = ValidacionesClase.validarCampo(null, 5, 20, 'Tema');
        expect(resultado, isNotNull);
      });
    });

    group('Validación de Nombre', () {
      test('Nombre válido con 5 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Clase',
          5,
          20,
          'Nombre',
        );
        expect(resultado, isNull);
      });

      test('Nombre inválido con 3 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Mat',
          5,
          20,
          'Nombre',
        );
        expect(resultado, isNotNull);
      });

      test('Nombre inválido > 20 caracteres', () {
        String? resultado = ValidacionesClase.validarCampo(
          'Clase de Matemáticas Avanzadas',
          5,
          20,
          'Nombre',
        );
        expect(resultado, isNotNull);
      });

      test('Nombre vacío', () {
        String? resultado = ValidacionesClase.validarCampo('', 5, 20, 'Nombre');
        expect(resultado, isNotNull);
      });
    });

    group('Validaciones Combinadas', () {
      test('Ambos campos válidos', () {
        expect(
          ValidacionesClase.validarCampo('Clase Básica', 5, 20, 'Nombre'),
          isNull,
        );
        expect(
          ValidacionesClase.validarCampo('Matemáticas', 5, 20, 'Tema'),
          isNull,
        );
      });

      test('Nombre válido y Tema inválido', () {
        expect(
          ValidacionesClase.validarCampo('Clase Básica', 5, 20, 'Nombre'),
          isNull,
        );
        expect(ValidacionesClase.validarCampo('Mat', 5, 20, 'Tema'), isNotNull);
      });

      test('Nombre inválido y Tema válido', () {
        expect(
          ValidacionesClase.validarCampo('Mat', 5, 20, 'Nombre'),
          isNotNull,
        );
        expect(
          ValidacionesClase.validarCampo('Matemáticas', 5, 20, 'Tema'),
          isNull,
        );
      });
    });
  });
}
