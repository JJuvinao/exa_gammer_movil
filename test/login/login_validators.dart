class LoginValidators {
  static String? validarUsuario(String user) {
    if (user.isEmpty) {
      return 'El nombre de usuario no puede estar vacío';
    }

    if (user.length < 10) {
      return 'El usuario debe tener al menos 10 caracteres';
    }

    if (user.length > 40) {
      return 'El usuario no puede superar los 40 caracteres';
    }

    // Solo imprime si TODO está correcto
    print("✔️ Usuario válido: '$user'");
    return null;
  }

  static String? validarPassword(String pass) {
    if (pass.isEmpty) {
      return 'La contraseña no puede estar vacía';
    }

    if (pass.length < 8) {
      return 'La contraseña debe tener mínimo 8 caracteres';
    }

    // Solo imprime si TODO está correcto
    print("✔️ Contraseña válida (oculta por seguridad)");
    return null;
  }
}
