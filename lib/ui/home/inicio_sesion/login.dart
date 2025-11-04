import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginForm> {
  final usuario = TextEditingController();
  final clave = TextEditingController();
  final UserController userController = Get.find<UserController>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Campo Usuario
        TextField(
          controller: usuario,
          style: const TextStyle(color: Colors.white), // 🔹 texto blanco
          decoration: _input('Usuario', Icons.person),
        ),
        const SizedBox(height: 16),

        // Campo Contraseña
        TextField(
          controller: clave,
          style: const TextStyle(color: Colors.white), // 🔹 texto blanco
          obscureText: _obscureText,
          decoration: _input('Contraseña', Icons.lock).copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF00F0FF), // color neón del tema
              ),
              onPressed: () => setState(() {
                _obscureText = !_obscureText;
              }),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Botón Iniciar Sesión
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: _buttonStyle(),
            onPressed: () async {
              final rol = await userController.iniciarSesionYObtenerRol(
                usuario.text,
                clave.text,
              );

              if (rol != null) {
                Get.snackbar(
                  'Éxito',
                  'Inicio de sesión exitoso como $rol',
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                );

                usuario.clear();
                clave.clear();

                if (!Get.isRegistered<ClaseController>()) {
                  Get.put(ClaseController());
                }

                if (rol == 'Profesor') {
                  Get.offAll(() => MainView(vista: "Profesor"));
                } else if (rol == 'Estudiante') {
                  Get.off(() => MainView(vista: "Estudiante"));
                } else {
                  Get.snackbar(
                    'Error',
                    'Rol no reconocido: $rol',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              } else {
                Get.snackbar(
                  'Error',
                  'Usuario o contraseña incorrectos',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: const Text(
              'INICIAR SESIÓN',
              style: TextStyle(fontSize: 16, fontFamily: "Inter"),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Estilo de los TextFields
  InputDecoration _input(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: const Color(0xFF00F0FF)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: const Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF00F0FF),
          width: 2,
        ),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05), // sutil glass effect
    );
  }

  // 🔹 Estilo del botón
  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00F0FF),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        shadowColor: const Color(0xFF00F0FF).withOpacity(0.5),
      );
}