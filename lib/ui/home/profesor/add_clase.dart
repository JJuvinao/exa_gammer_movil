import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:exa_gammer_movil/ui/home/widget/avatares.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class Agregarclase extends StatefulWidget {
  Agregarclase({super.key});

  @override
  State<Agregarclase> createState() => _AgregarclaseState();
}

class _AgregarclaseState extends State<Agregarclase> {
  final ClaseController pc = Get.find();

  final UserController usercontroller = Get.find<UserController>();

  final TextEditingController txtNombre = TextEditingController();

  final TextEditingController txtTema = TextEditingController();

  bool mostaravatar = false;
  String? selecionAvatar;

  final List<String> avatarList = [
    "assets/fondo/cieloatardecer.jpg",
    "assets/fondo/cieloazul.jpg",
    "assets/fondo/cielomorado.jpg",
    "assets/fondo/cielonoche.jpg",
    "assets/fondo/fondo1.jpg",
  ];

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
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
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

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (mostaravatar == true)
                        ClipOval(
                          child: Image.asset(
                            selecionAvatar!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(height: 16),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        onPressed: () async {
                          final avatar = await AvatarSelectorModal.show(
                            context,
                            avatarList,
                          );
                          if (avatar != null) {
                            setState(() {
                              selecionAvatar = avatar;
                              mostaravatar = true;
                            });
                          }
                        },
                        child: const Text('Elegir avatar'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (txtNombre.text.isEmpty ||
                          txtTema.text.isEmpty ||
                          selecionAvatar == null) {
                        Get.snackbar(
                          'Error',
                          'Por favor completa todos los campos.',
                        );
                      } else {
                        Clasedto newclase = Clasedto(
                          nombre: txtNombre.text,
                          tema: txtTema.text,
                          autor: txtAutor.text,
                          imagenClase: selecionAvatar!,
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
                          Get.to(() => MainView(vista: "Profesor"));
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
