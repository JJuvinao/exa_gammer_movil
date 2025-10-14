import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/dialogs/dialogo_ingresar_clase.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';
import 'package:exa_gammer_movil/ui/home/profesor/detalle_clase.dart';

class HomeEstudiante extends StatelessWidget {
  final ClaseController pc = Get.find();
  HomeEstudiante({super.key});

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
            children: [
              // Encabezado con logo y texto
              const SizedBox(height: 24),
              Row(
                children: [
                  Image.asset('assets/imagen/logo_exa.png', height: 75),
                  const SizedBox(width: 12),
                  const Text(
                    'EXA-GAMMER',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TitanOne",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Campo de búsqueda
              BuscarClase(),
              const SizedBox(height: 10),

              // Lista de clases
              Expanded(
                child: Obx(() {
                  final filteredClase = pc.filteredList;

                  if (filteredClase.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay clases registradas.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredClase.length,
                    itemBuilder: (BuildContext context, int index) {
                      final clase = filteredClase[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(child: Text(clase.nombre[0])),
                          title: Text(clase.nombre),
                          subtitle: Text('${clase.tema} - ${clase.autor}'),
                          onTap: () {
                            Get.to(() => DetalleClase());
                          },
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
          IngresarCodigo(context); // ✅ LLAMADA
        },
        child: const Icon(Icons.meeting_room),
      ),
    );
  }
}
