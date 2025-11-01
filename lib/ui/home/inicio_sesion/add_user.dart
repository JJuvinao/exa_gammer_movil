import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';

class AgregarUsuario extends StatefulWidget {
  @override
  _AgregarUsuarioState createState() => _AgregarUsuarioState();
}

class _AgregarUsuarioState extends State<AgregarUsuario> {
  final usuario = TextEditingController();
  final clave = TextEditingController();
  final email = TextEditingController();
  final List<String> roles = ['Estudiante', 'Profesor'];
  String? selectedRole;

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
        SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: _input('Rol'),
          items: roles
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: (value) => setState(() => selectedRole = value),
        ),
        SizedBox(height: 16),
        TextField(controller: email, decoration: _input('Correo electrónico')),
        SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: _buttonStyle(),

            onPressed: () async {
              if (selectedRole != null) {
                var res = await userController.registerUser(
                  usuario.text,
                  clave.text,
                  selectedRole!,
                  email.text,
                );
                if (!res) {
                  Get.snackbar(
                    'Registro fallido',
                    'El usuario no se pudo registrar  correctamente',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 3),
                  );
                  return;
                }
                Get.snackbar(
                  'Registro exitoso',
                  'El usuario ha sido registrado correctamente',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 3),
                );

                usuario.clear();
                clave.clear();
                email.clear();
                setState(() => selectedRole = null);

                Future.delayed(Duration(seconds: 2), () {
                  Get.back();
                });
              } else {
                Get.snackbar(
                  'Error',
                  'Por favor seleccione un rol',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },

            child: Text(
              'REGISTRARSE',
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
    backgroundColor: Color(0xFF42A5F5),
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 16),
  );
}
