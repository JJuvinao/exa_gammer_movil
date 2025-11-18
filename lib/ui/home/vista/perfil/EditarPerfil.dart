import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/user_model.dart';

class EditarPerfilView extends StatefulWidget {
  const EditarPerfilView({super.key});

  @override
  State<EditarPerfilView> createState() => _EditarPerfilViewState();
}

class _EditarPerfilViewState extends State<EditarPerfilView> {
  final UserController userController = Get.find<UserController>();

  late TextEditingController nombreController;
  late TextEditingController correoController;

  @override
  void initState() {
    super.initState();
    final user = userController.getuser;
    nombreController = TextEditingController(text: user.username);
    correoController = TextEditingController(text: user.email);
  }

  Future<void> _guardarCambios() async {
  final nombre = nombreController.text.trim().isEmpty
      ? userController.getuser.username
      : nombreController.text.trim();

  final correo = correoController.text.trim().isEmpty
      ? userController.getuser.email
      : correoController.text.trim();

  final actualizado = User(
    id: userController.getuser.id,
    username: nombre,
    rol: userController.getuser.rol,
    email: correo,
    img: userController.getuser.img,
    premium: userController.getuser.premium,
  );

  final exito = await userController.actualizarUsuario(actualizado);

  if (exito) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF16213e),
        title: const Text("Perfil actualizado", style: TextStyle(color: Colors.cyan)),
        content: const Text("Tus cambios se guardaron correctamente.", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); 
              Get.back(); 
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.cyan)),
          ),
        ],
      ),
    );
  } else {
    Get.snackbar("❌ Error", "No se pudo actualizar el perfil",
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0a0a14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Editar Perfil", style: TextStyle(color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: nombreController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Nombre",
              labelStyle: TextStyle(color: Colors.cyan),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: correoController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Correo",
              labelStyle: TextStyle(color: Colors.cyan),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _guardarCambios,
            label: const Text("Editar", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}