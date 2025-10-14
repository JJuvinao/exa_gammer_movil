import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';
import 'package:exa_gammer_movil/ui/home/editar.dart';
import 'package:exa_gammer_movil/ui/home/eliminar.dart';
import 'package:exa_gammer_movil/ui/home/profesor/add_clase.dart';
import 'package:exa_gammer_movil/ui/home/profesor/detalle_clase.dart';

class HomeProfesor extends StatelessWidget {
  final ClaseController pc = Get.find();
  HomeProfesor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: Color(0xFFC8C1C1),
        elevation: 0,
        toolbarHeight: 0, 
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              
              // Encabezado con logo y texto
              SizedBox(height: 24),
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
                      final realIndex = pc.claseList.indexOf(clase);

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(clase.nombre[0]),
                          ),
                          title: Text(clase.nombre),
                          subtitle: Text('${clase.tema} - ${clase.autor}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(() => UpdateClase(index: realIndex));
                                },
                                icon: const Icon(Icons.edit, color: Colors.blue),
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteClase(context: context, index: realIndex);
                                },
                                icon: const Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
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
          Get.to(() => Agregarclase());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}