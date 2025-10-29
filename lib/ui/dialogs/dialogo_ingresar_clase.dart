import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';

Future<bool?> IngresarCodigo(BuildContext context) async {
  final TextEditingController codigoController = TextEditingController();
  final UserController usercontroller = Get.find<UserController>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Text(
              'EXA-GAMMER',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "TitanOne",
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ingresa el código de la clase para unirte:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                labelText: 'Código de clase',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final codigo = codigoController.text.trim();
              final exito = await usercontroller.UnirseClase(codigo);
              if (exito) {
                Get.snackbar(
                  'Éxito',
                  'Te has unido a la clase con éxito.',
                  backgroundColor: Colors.green[100],
                  colorText: Colors.black,
                  snackPosition: SnackPosition.BOTTOM,
                );
                Navigator.pop(context, true);
              } else {
                Get.snackbar(
                  'Error',
                  'Por favor ingresa un código válido.',
                  backgroundColor: Colors.red[100],
                  colorText: Colors.black,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text('Unirse'),
          ),
        ],
      );
    },
  );
  return null;
}
