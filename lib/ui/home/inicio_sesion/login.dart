import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/home_profesor.dart';
import 'package:exa_gammer_movil/ui/home/estudiante/home_estudiante.dart';

class LoginForm extends StatelessWidget {
  final usuario = TextEditingController();
  final clave = TextEditingController();
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: usuario, decoration: _input('Usuario')),
        SizedBox(height: 16),
        TextField(
          controller: clave,
          obscureText: true,
          decoration: _input('Contraseña'),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: _buttonStyle(),
            onPressed: () {
              final rol = userController.iniciarSesionYObtenerRol(
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

                // Asegurar que ClaseController esté registrado
                if (!Get.isRegistered<ClaseController>()) {
                  Get.put(ClaseController());
                }

                // ✅ Redirigir según rol
                if (rol == 'Profesor') {
                  Get.to(() => HomeProfesor());
                } else if (rol == 'Estudiante') {
                  Get.to(() => HomeEstudiante());
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
            child: Text(
              'INICIAR SESIÓN',
              style: TextStyle(fontSize: 16, fontFamily: "Inter"),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _input(String label) =>
      InputDecoration(labelText: label, border: OutlineInputBorder());

  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0D59A1),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
      );
}