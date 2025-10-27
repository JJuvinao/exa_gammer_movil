import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:exa_gammer_movil/ui/home/profesor/home_profesor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class Agregarclase extends StatelessWidget {
  final ClaseController pc = Get.find();
  final UserController usercontroller = Get.find<UserController>();

  Agregarclase({super.key});

  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtTema = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var user = usercontroller.getuser;
    var token = usercontroller.gettoken;
    final TextEditingController txtAutor = TextEditingController(
      text: user.username,
    );
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
                      'Crear clase',
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.bolt, color: Colors.amber),
                      const SizedBox(width: 10),
                      const Text(
                        'Seleccionar avatar',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Elegir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (txtNombre.text.isEmpty || txtTema.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Por favor completa todos los campos.',
                        );
                      } else {
                        Clasedto newclase = Clasedto(
                          nombre: txtNombre.text,
                          tema: txtTema.text,
                          autor: txtAutor.text,
                          imagenClase: "assets/avatars/avatar1.jpg",
                          id_Profe: user.id,
                        );
                        var res = await pc.AddClase(newclase, token);
                        if (res == true) {
                          Get.snackbar(
                            'Éxito',
                            'Clase creada correctamente.',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 3),
                          );
                          Get.to(() => HomeProfesor());
                        } else {
                          Get.snackbar(
                            'Error',
                            'No se pudo crear la clase. Inténtalo de nuevo.',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                            duration: Duration(seconds: 3),
                          );
                        }
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Crear clase'),
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
