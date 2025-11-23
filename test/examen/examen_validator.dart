class ExamenValidator {
  static final RegExp _caracteresProhibidos = RegExp(r'[!@#\$%&/=\?¿¡\*]');

  // ============================
  // VALIDAR NOMBRE
  // ============================
  static bool validarNombre(String nombre) {
    if (nombre.isEmpty) return false;

    if (nombre.length < 5) return false;

    if (_caracteresProhibidos.hasMatch(nombre)) return false;

    print("✔️ Nombre válido: $nombre");
    return true;
  }

  // ============================
  // VALIDAR TEMA
  // ============================
  static bool validarTema(String tema) {
    if (tema.isEmpty) return false;

    if (tema.length < 5) return false;

    print("✔️ Tema válido: $tema");
    return true;
  }

  // ============================
  // VALIDAR DESCRIPCIÓN
  // ============================
  static bool validarDescripcion(String descripcion) {
    if (descripcion.isEmpty) return false;

    if (descripcion.length < 10) return false;

    print("✔️ Descripción válida");
    return true;
  }

  // ============================
  // VALIDAR LISTA DE PREGUNTAS
  // ============================
  static bool validarListaPreguntas(List preguntas) {
    if (preguntas.isEmpty) return false;

    if (preguntas.length < 5) return false;

    print("✔️ Lista de preguntas válida (${preguntas.length} ítems)");
    return true;
  }
}
