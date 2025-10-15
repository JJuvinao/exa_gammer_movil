import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/actividad_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/add_actividad.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetalleClase extends StatelessWidget {
  final ExamenController actividadController = Get.put(ExamenController());
  final UserController usercontroller = Get.find<UserController>();
  final clase clasek;

  DetalleClase({super.key, required this.clasek});

  @override
  Widget build(BuildContext context) {
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
                  final actividades = actividadController.filteredList(
                    user.id,
                    token,
                  );

                  if (actividades.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay actividades registradas.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: actividades.length,
                    itemBuilder: (context, index) {
                      final actividad = actividades[index];

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
