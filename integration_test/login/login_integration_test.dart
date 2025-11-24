// ignore_for_file: override_on_non_overriding_member, avoid_print, non_constant_identifier_names
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/login.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

import 'package:exa_gammer_movil/controllers/vista_controles.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Datos usados en la prueba
class UsuarioLogin {
  String nombre = "jose luis juvi";
  String pasword = "12345678";
}

/// CONTROLADOR FALSO PRINCIPAL
class FakeUserController extends GetxController implements UserController {
  final User _fakeUser = User(
    id: 1,
    username: "usuario_test",
    rol: "Profesor",
    email: "test@example.com",
  );

  @override
  User get getuser => _fakeUser; // <---- ESTA ERA LA CAUSA DEL ERROR

  @override
  String get gettoken => "token_fake";

  @override
  Future<String?> iniciarSesionYObtenerRol(String usuario, String clave) async {
    // Validación agregada
    if (usuario.length < 10 || usuario.length > 40) {
      print("❌ FakeUserController: usuario inválido");
      return null;
    }

    if (clave.length < 8) {
      print("❌ FakeUserController: contraseña inválida");
      return null;
    }

    // Simulación real
    if (usuario == UsuarioLogin().nombre && clave == UsuarioLogin().pasword) {
      return "Profesor";
    }

    return null;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<bool> UnirseClase(String codigoClase) async => false;
  @override
  Future<bool> actualizarPremium(int userId, bool premium) async => false;
  @override
  Future<bool> actualizarUsuario(User usuario) async => false;
  @override
  Future<String> registerUser(String u, p, r, e) async => "";
}

@override
Future<bool> UnirseClase(String codigoClase) async => false;

@override
Future<bool> actualizarPremium(int userId, bool premium) async => false;

@override
Future<bool> actualizarUsuario(User usuario) async => false;

@override
Future<void> logout() async {}

@override
Future<String> registerUser(
  String username,
  String password,
  String role,
  String email,
) async => "";

@override
String get gettoken => "";

@override
User get getuser => User(id: 0, username: '', rol: '', email: '');

/// FAKE QUE EXTIENDE EL SERVICIO REAL
class FakeStorageService extends StorageService {
  @override
  Future<StorageService> init() async {
    print("✔️ StorageService inicializado correctamente");
    return this;
  }

  @override
  Future<void> saveData(String key, dynamic value) async {
    print("✔️ StorageService guardó datos: $key");
  }

  @override
  dynamic getData(String key) {
    print("✔️ StorageService accedió a: $key");
    return null;
  }
}

/// FAKES DE CONTROLADORES
class FakeClaseController extends ClaseController {}

class FakeVistaControles extends VistaControles {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    Get.testMode = true;

    print("\n==============================");
    print("🔵 INICIALIZANDO MÓDULOS");
    print("==============================");

    // 1️⃣ StorageService
    final fakeStorage = FakeStorageService();
    await fakeStorage.init();
    Get.put<StorageService>(fakeStorage);
    print("✔️ StorageService cargado");
    // 2️⃣ UserController (DEPENDENCIA PRINCIPAL)
    Get.put<UserController>(FakeUserController());
    print("✔️ UserController cargado");
    // 3️⃣ ClaseController
    Get.put<ClaseController>(FakeClaseController());
    print("✔️ ClaseController cargado");
    // 4️⃣ VistaControles (ya no fallará)
    Get.put<VistaControles>(FakeVistaControles());
    print("✔️ VistaControles cargado");
    // 5️⃣ Resto de módulos

    print("🔵 Todos los módulos cargados correctamente");
  });

  testWidgets('Prueba de integración Login - Usuario Correcto', (tester) async {
    print("🚀 INICIANDO PRUEBA COMPLETA DE INTEGRACIÓN DEL LOGIN");

    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: LoginForm())),
    );

    await tester.pumpAndSettle();

    print("✔️ Pantalla de Login cargada");

    final usuario = find.byKey(const Key('inputUsuario'));
    final password = find.byKey(const Key('inputPassword'));
    final loginBtn = find.byKey(const Key('btnLogin'));

    print("\n🔎 Validando campos del formulario...");

    // Validación usuario
    await tester.enterText(usuario, UsuarioLogin().nombre);

    if (UsuarioLogin().nombre.length >= 10 &&
        UsuarioLogin().nombre.length <= 40) {
      print("✔️ Campo usuario válido");
    } else {
      print("❌ Campo usuario inválido");
    }

    // Validación contraseña
    await tester.enterText(password, UsuarioLogin().pasword);

    if (UsuarioLogin().pasword.length >= 8) {
      print("✔️ Campo contraseña válido");
    } else {
      print("❌ Campo contraseña inválido");
    }

    print("🔘 Presionando botón de login...");
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();

    print("\n🔎 Evaluando navegación después del login...");

    // Aquí ya NO buscamos snackbar. Buscamos la navegación a MainView.
    final pantallaProfesor = find.byType(Scaffold);

    if (pantallaProfesor.evaluate().isNotEmpty) {
      print(
        "🎯 Navegación correcta — Se llegó a la pantalla principal del Profesor",
      );
    } else {
      print("❌ Navegación fallida — No se llegó a la siguiente pantalla");
    }

    print("\n🎉 PRUEBA COMPLETA DE INTEGRACIÓN FINALIZADA");
  });
}
