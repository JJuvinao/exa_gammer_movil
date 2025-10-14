import 'package:flutter/material.dart';
import 'package:get/get.dart';

void IngresarCodigo(BuildContext context) {
  final TextEditingController codigoController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Image.asset('assets/imagen/logo_exa.png', height: 40),
            const SizedBox(width: 12),
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
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final codigo = codigoController.text.trim();
              Navigator.pop(context);

              if (codigo.isEmpty) {
                Get.snackbar(
                  'Error',
                  'Por favor ingresa un código válido.',
                  backgroundColor: Colors.red[100],
                  colorText: Colors.black,
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }

              Get.snackbar(
                'Código ingresado',
                'Intentando unirse con código: $codigo',
                backgroundColor: Colors.blue[100],
                colorText: Colors.black,
                snackPosition: SnackPosition.BOTTOM,
              );

              // TODO: Validar si el código existe y unir a la clase
            },
            child: const Text('Unirse'),
          ),
        ],
      );
    },
  );
}
