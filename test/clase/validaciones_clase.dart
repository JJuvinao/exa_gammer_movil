class ValidacionesClase {
  /// Valida un campo de texto con límites mínimos y máximos
  static String? validarCampo(
    String? valor,
    int min,
    int max,
    String nombreCampo,
  ) {
    if (valor == null || valor.isEmpty) {
      return '$nombreCampo no puede estar vacío';
    }

    if (valor.length < min) {
      return '$nombreCampo debe tener al menos $min caracteres';
    }

    if (valor.length > max) {
      return '$nombreCampo debe tener máximo $max caracteres';
    }

    // Solo imprime si todo está totalmente correcto
    print("✔️ $nombreCampo válido: '$valor'");
    return null; // Válido
  }
}
