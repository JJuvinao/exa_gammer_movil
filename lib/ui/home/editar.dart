import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class UpdateClase extends StatelessWidget {
  final ClaseController pc = Get.find();
  final int index;

  UpdateClase({super.key, required this.index});

  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtTema = TextEditingController();
  final TextEditingController txtAutor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Prellenar campos con datos existentes
    final clase = pc.claseList[index];
    txtNombre.text = clase.nombre;
    txtTema.text = clase.tema;
    txtAutor.text = clase.autor;

    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/imagen/logo_exa.png', height: 50),
                const SizedBox(width: 8),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'EXA-GAMMER',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "TitanOne",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Editar clase',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(txtNombre, 'Nombre', Icons.class_),
                  const SizedBox(height: 10),
                  _buildTextField(txtTema, 'Tema', Icons.topic),
                  const SizedBox(height: 10),
                  _buildTextField(txtAutor, 'Autor', Icons.person),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (txtNombre.text.isEmpty ||
                          txtTema.text.isEmpty ||
                          txtAutor.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Por favor completa todos los campos.',
                        );
                      } else {
                        pc.updateClase(
                          index,
                          txtNombre.text,
                          txtTema.text,
                          txtAutor.text,
                        );
                        Get.snackbar('Éxito', 'Clase actualizada correctamente.');
                        Future.delayed(Duration(seconds: 1), () => Get.back());
                      }
                      Get.back();
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Guardar cambios'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D59A1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

