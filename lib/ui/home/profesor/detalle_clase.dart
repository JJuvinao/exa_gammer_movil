import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/add_actividad.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:exa_gammer_movil/game/ahorcado/ahorcado_page.dart';
import 'package:exa_gammer_movil/ui/home/profesor/detalle_examen.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class DetalleClase extends StatelessWidget {
  final ExamenController examenController = Get.put(ExamenController());
  final UserController usercontroller = Get.find<UserController>();
  final ClaseController claseController = Get.find<ClaseController>();

  DetalleClase({super.key});

  @override
  Widget build(BuildContext context) {
    final clasek = claseController.getclase;
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(() => AhorcadoPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "IR AL JUEGO",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              Row(
                children: [
                  Image.asset('assets/imagen/logo_exa.png', height: 75),
                  const SizedBox(width: 12),
                  Flexible(
                    child: AutoSizeText(
                      clasek.nombre.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "TitanOne",
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Título sección
              const Text(
                'Actividades',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
              const SizedBox(height: 12),

              // Lista de actividades
              Expanded(
                child: Obx(() {
                  final user = usercontroller.getuser;
                  final token = usercontroller.gettoken;
                  final examenes = examenController.filteredList(
                    user.id,
                    token,
                  );

                  if (examenes.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay actividades registradas.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: examenes.length,
                    itemBuilder: (context, index) {
                      final actividad = examenes[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            actividad.nombre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onTap: () => Get.to(() => DetalleExamenPage()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text('Tema: ${actividad.tema}'),
                              const SizedBox(height: 4),
                              Text('Descripción: ${actividad.descripcion}'),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddActividad());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
