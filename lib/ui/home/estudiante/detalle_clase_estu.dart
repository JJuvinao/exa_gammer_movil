import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class DetalleClase_Estu extends StatefulWidget {
  DetalleClase_Estu({super.key});

  @override
  State<DetalleClase_Estu> createState() => _DetalleClase_EstuState();
}

class _DetalleClase_EstuState extends State<DetalleClase_Estu> {
  late final ExamenController examenController;

  late final UserController usercontroller;

  late final ClaseController claseController;
  var examenes = <dynamic>[].obs;

  @override
  void initState() {
    super.initState();
    usercontroller = Get.find<UserController>();
    examenController = Get.put(ExamenController());
    claseController = Get.find<ClaseController>();
    cargarExamen();
  }

  void cargarExamen() async {
    final clasek = claseController.getclase;
    final token = usercontroller.gettoken;
    examenes.value = await examenController.filteredList(clasek.id, token);
  }

  Widget build_Examenes(BuildContext context) {
    return Obx(() {
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
              onTap: () => {
                examenController.saveExamen(actividad),
                Get.to(() => ExamenView(vista: "Examen")),
              },
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          await Get.to(MainView(vista: usercontroller.getuser.rol)),
      child: Scaffold(
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
                        "prueba",
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

                const Text(
                  'Actividades',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Inter",
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(child: build_Examenes(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
