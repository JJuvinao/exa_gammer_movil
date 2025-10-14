import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/user_model.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;

  final List<Map<String, String>> usuariosRegistrados = [
  ];

  /// Agrega un nuevo usuario a la lista dinámica
  void registerUser(String username, String password, String role, String email) {
    userList.add(User(
      usuario: username,
      clave: password,
      rol: role,
      email: email,
    ));
    print('✅ Usuario registrado: $username');
  }

  String? iniciarSesionYObtenerRol(String username, String password) {
    // 1. Buscar en los usuarios registrados por defecto
    final defaultUser = usuariosRegistrados.firstWhereOrNull(
      (user) => user['usuario'] == username && user['clave'] == password,
    );

    if (defaultUser != null) {
      print('🔓 Usuario por defecto autenticado: ${defaultUser['usuario']}');
      return defaultUser['rol'];
    }

    // 2. Buscar en los usuarios registrados dinámicamente
    final dynamicUser = userList.firstWhereOrNull(
      (user) => user.usuario == username && user.clave == password,
    );

    if (dynamicUser != null) {
      print('🔓 Usuario registrado autenticado: ${dynamicUser.usuario}');
      return dynamicUser.rol;
    }

    // 3. Usuario no encontrado
    print('Credenciales incorrectas para $username');
    return null;
  }
}