import 'package:flutter_test/flutter_test.dart';
import 'examen_validator.dart';

void main() {
  group('Validación de Nombre', () {
    test('Nombre válido (5 caracteres)', () {
      expect(ExamenValidator.validarNombre('exame'), true);
    });

    test('Nombre inválido (4 caracteres)', () {
      expect(ExamenValidator.validarNombre('exam'), false);
    });

    test('Nombre inválido con caracteres especiales', () {
      expect(ExamenValidator.validarNombre('exa@men'), false);
    });

    test('Nombre inválido vacío', () {
      expect(ExamenValidator.validarNombre(''), false);
    });
  });

  group('Validación de Tema', () {
    test('Tema válido', () {
      expect(ExamenValidator.validarTema('apoyo'), true);
    });

    test('Tema inválido (<5)', () {
      expect(ExamenValidator.validarTema('apa'), false);
    });

    test('Tema vacío', () {
      expect(ExamenValidator.validarTema(''), false);
    });
  });

  group('Validación de Descripción', () {
    test('Descripción válida', () {
      expect(ExamenValidator.validarDescripcion('Examen de prueba'), true);
    });

    test('Descripción inválida (<10)', () {
      expect(ExamenValidator.validarDescripcion('Examen'), false);
    });

    test('Descripción vacía', () {
      expect(ExamenValidator.validarDescripcion(''), false);
    });
  });

  group('Validación Lista de Preguntas', () {
    test('Lista válida (>=5)', () {
      expect(
        ExamenValidator.validarListaPreguntas(['a', 'b', 'c', 'd', 'e']),
        true,
      );
    });

    test('Lista inválida (<5)', () {
      expect(ExamenValidator.validarListaPreguntas(['a', 'b']), false);
    });

    test('Lista vacía', () {
      expect(ExamenValidator.validarListaPreguntas([]), false);
    });
  });
}
