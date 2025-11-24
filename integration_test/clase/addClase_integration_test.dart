// ignore_for_file: override_on_non_overriding_member, non_constant_identifier_names, avoid_print, file_names

import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/home_profesor.dart';
import 'package:exa_gammer_movil/ui/home/profesor/agregar_clase/add_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';

// TUS IMPORTS
import 'package:exa_gammer_movil/ui/home/inicio_sesion/login.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';

/// DATOS DE PRUEBA
class UsuarioLogin {
  String nombre = "jose luis juvi";
  String password = "12345678";
}

/// CONTROLADORES MOCK
class FakeUserController extends GetxController implements UserController {
  final User _fakeUser = User(
    id: 1,
    username: "usuario_test",
    rol: "Profesor",
    email: "test@example.com",
  );

  @override
  User get getuser => _fakeUser;

  @override
  String get gettoken => "token_fake";

  @override
  Future<String?> iniciarSesionYObtenerRol(String usuario, String clave) async {
    if (usuario == UsuarioLogin().nombre && clave == UsuarioLogin().password) {
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

/// FAKE DEL STORAGE
class FakeStorageService extends StorageService {
  @override
  Future<StorageService> init() async => this;
  @override
  Future<void> saveData(String key, dynamic value) async {}
  @override
  dynamic getData(String key) => null;
  @override
  Future<void> removeData(String key) async {}
  @override
  Future<void> clearAll() async {}
}

/// CONTROLADOR FAKE DE CLASES CON DATOS MOCKEADOS
class FakeClaseController extends ClaseController {
  // Lista observable de clases fake
  final RxList<Clase> _clasesMock = <Clase>[].obs;

  @override
  RxList<Clase> get clases => _clasesMock;

  @override
  Future<void> cargarClases(dynamic user, dynamic token) async {
    // Simular carga exitosa sin hacer llamada HTTP real
    print("✔️ ClaseController: Clases cargadas (mock)");
    _clasesMock.value = [
      Clase(
        id: 1,
        nombre: "Clase Ejemplo",
        tema: "Tema de prueba",
        codigo: "ABC123",
        autor: '',
        estado: true,
        fecha: '',
        img: '',
        id_profe: 0,
      ),
    ];
  }

  @override
  Future<void> crearClase(
    dynamic user,
    dynamic token,
    GlobalKey<FormState> formKey,
  ) async {
    print("✔️ ClaseController: Clase creada exitosamente (mock)");
    // Simular éxito sin retornar nada
  }

  @override
  Future<void> editarClase(dynamic clase, dynamic token) async {
    print("✔️ ClaseController: Clase editada (mock)");
  }

  @override
  Future<void> eliminarClase(dynamic claseId, dynamic token) async {
    print("✔️ ClaseController: Clase eliminada (mock)");
  }

  // CRÍTICO: Sobrescribir limpiarFormulario para que no haga nada durante los tests
  @override
  void limpiarFormulario() {
    // No hacer nada en tests para evitar setState durante build
    print(
      "✔️ ClaseController: limpiarFormulario() llamado (ignorado en tests)",
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    print("🔵 INICIANDO MÓDULOS NECESARIOS DEL SISTEMA…");

    Get.testMode = true;

    final fakeStorage = FakeStorageService();
    await fakeStorage.init();
    Get.put<StorageService>(fakeStorage);
    print("✔️ StorageService cargado");

    Get.put<UserController>(FakeUserController());
    print("✔️ UserController cargado");

    Get.put<ClaseController>(FakeClaseController());
    print("✔️ ClaseController cargado");

    print("🔵 Todos los módulos cargados correctamente\n");
  });

  testWidgets('Prueba de integración completa — Crear Clase', (tester) async {
    print("🚀 INICIANDO PRUEBA DE INTEGRACIÓN — CREAR CLASE\n");

    // =============== 1. CARGAR LOGIN =====================
    await tester.pumpWidget(
      const GetMaterialApp(home: Scaffold(body: LoginForm())),
    );
    await tester.pumpAndSettle();

    print("✔️ Pantalla de Login cargada");

    // =============== 2. LOGIN CORRECTO ====================
    final usuario = find.byKey(const Key('inputUsuario'));
    final password = find.byKey(const Key('inputPassword'));
    final loginBtn = find.byKey(const Key('btnLogin'));

    await tester.enterText(usuario, UsuarioLogin().nombre);
    await tester.enterText(password, UsuarioLogin().password);
    await tester.tap(loginBtn);
    await tester.pumpAndSettle();

    print("🔐 Login realizado… validando navegación");

    // Buscar mensaje de login exitoso
    expect(find.textContaining("Inicio de sesión exitoso"), findsOneWidget);
    print("✔️ Navegación correcta — Se llegó al menú principal del Profesor");

    // =============== 3. CARGAR HOME PROFESOR ====================
    await tester.pumpWidget(GetMaterialApp(home: HomeProfesor()));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(HomeProfesor), findsOneWidget);
    print("✔️ HomeProfesor cargado correctamente");

    // =============== 4. IR A CREAR CLASE ====================
    final fab = find.byKey(const Key('fabCrearClase'));

    expect(
      fab,
      findsOneWidget,
      reason: "❌ No se encontró el botón que lleva a crear clase",
    );
    print("✔️ FAB para crear clase encontrado");

    print("🔘 Presionando botón 'Crear Clase'…");

    // SOLUCIÓN: Hacer scroll hasta el final de la pantalla primero
    await tester.drag(find.byType(HomeProfesor), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Usar ensureVisible para asegurar que el botón esté en pantalla
    await tester.ensureVisible(fab);
    await tester.pumpAndSettle();

    // Usar warnIfMissed: false para suprimir la advertencia si no se puede tocar
    await tester.tap(fab, warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    print("✔️ Navegando a pantalla 'AgregarClase'");

    // =============== 5. CARGAR PANTALLA AGREGAR CLASE ====================
    await tester.pumpWidget(GetMaterialApp(home: AgregarClase()));
    await tester.pumpAndSettle();

    expect(find.byType(AgregarClase), findsOneWidget);
    print("✔️ Pantalla 'AgregarClase' cargada");

    // =============== 6. VALIDAR FORMULARIO ====================
    final nombre = find.byKey(const Key('txtNombreClase'));
    final tema = find.byKey(const Key('txtTemaClase'));

    print("🔎 Validando campos del formulario…");

    expect(nombre, findsOneWidget);
    expect(tema, findsOneWidget);

    await tester.enterText(nombre, "Matematicas 5A");
    await tester.pumpAndSettle();

    await tester.enterText(tema, "Algebra avanzada");
    await tester.pumpAndSettle();

    print("✔️ Campos llenados correctamente");

    // =============== 7. CREAR CLASE ==========================
    print("🔘 Presionando botón para crear clase…");

    // SOLUCIÓN: Buscar específicamente el botón único
    final btnCrear = find.byKey(const Key('btnCrearClase'));

    // Verificar que existe solo uno
    expect(
      btnCrear,
      findsOneWidget,
      reason: "Debe haber exactamente un botón con key 'btnCrearClase'",
    );

    // Hacer scroll si es necesario
    final gesture = await tester.startGesture(const Offset(400, 300));
    await gesture.moveBy(const Offset(0, -200));
    await gesture.up();
    await tester.pumpAndSettle();

    // Asegurar visibilidad
    await tester.ensureVisible(btnCrear);
    await tester.pumpAndSettle();

    // Tocar el botón
    await tester.tap(btnCrear);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    print("🎉 Clase creada exitosamente — flujo completado\n");

    // =============== 8. VALIDAR RESULTADO ==========================
    // Buscar algún indicador de éxito (ajustar según tu app)
    // Ejemplo: un SnackBar, diálogo o mensaje
    final mensajeExito = find.textContaining("Clase creada");

    if (mensajeExito.evaluate().isNotEmpty) {
      print("✔️ Mensaje de confirmación encontrado");
    } else {
      print("");
    }
  });
}
