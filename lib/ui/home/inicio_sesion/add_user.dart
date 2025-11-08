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
        // Usuario
        TextField(
          controller: usuario,
          style: const TextStyle(color: Colors.white),
          decoration: _input('Usuario', Icons.person),
        ),
        const SizedBox(height: 16),

        // Contraseña
        TextField(
          controller: clave,
          style: const TextStyle(color: Colors.white),
          obscureText: true,
          decoration: _input('Contraseña', Icons.lock),
        ),
        const SizedBox(height: 16),

        // Rol
        DropdownButtonFormField<String>(
          value: selectedRole,
          dropdownColor: const Color(0xFF1a1a2e), // fondo del dropdown
          decoration: _input('Rol', Icons.people),
          style: const TextStyle(color: Colors.white),
          iconEnabledColor: const Color(0xFF00F0FF),
          items: roles
              .map(
                (role) => DropdownMenuItem(
                  value: role,
                  child: Text(
                    role,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() => selectedRole = value),
        ),
        const SizedBox(height: 16),

        // Correo electrónico
        TextField(
          controller: email,
          style: const TextStyle(color: Colors.white),
          decoration: _input('Correo electrónico', Icons.email),
        ),
        const SizedBox(height: 24),

        // Botón registrar
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

                if (res == "false") {
                  Get.snackbar(
                    'Registro fallido',
                    'El usuario no se pudo registrar correctamente',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3),
                  );
                }

                if (res == "ok") {
                  Get.snackbar(
                    'Registro exitoso',
                    'El usuario ha sido registrado correctamente',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3),
                  );
                }
                if (res == "existe") {
                  Get.snackbar(
                    'Nombre de usuario ya registrado',
                    'El usuario ya se ha sido registrado',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 3),
                  );
                }
                usuario.clear();
                clave.clear();
                email.clear();
                setState(() => selectedRole = null);

                Future.delayed(const Duration(seconds: 2), () {
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
            child: const Text(
              'REGISTRARSE',
              style: TextStyle(fontSize: 16, fontFamily: "Inter"),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Campos de texto con estilo neón/glass
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
        borderSide: const BorderSide(color: Color(0xFF00F0FF), width: 2),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05), // efecto glass
    );
  }

  // 🔹 Botón con sombra neón
  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF00F0FF),
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 8,
    shadowColor: const Color(0xFF00F0FF).withOpacity(0.5),
  );
}
