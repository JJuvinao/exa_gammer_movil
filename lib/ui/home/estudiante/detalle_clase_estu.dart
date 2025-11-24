// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class DetalleClase_Estu extends StatefulWidget {
  const DetalleClase_Estu({super.key});

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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.assignment_rounded,
                size: 80,
                color: Color(0xFF00F0FF).withOpacity(0.4),
              ),
              const SizedBox(height: 16),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                ).createShader(bounds),
                child: Text(
                  'No hay actividades registradas',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'El profesor aún no ha asignado actividades.',
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        itemCount: examenes.length,
        itemBuilder: (context, index) {
          final actividad = examenes[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF00F0FF).withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.15),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              onTap: () {
                examenController.saveExamen(actividad);
                Get.to(() => ExamenView(vista: "Examen"));
              },
              title: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                ).createShader(bounds),
                child: Text(
                  actividad.nombre,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Tema: ${actividad.tema}",
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF00F0FF),
                size: 18,
              ),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => MainView(vista: usercontroller.getuser.rol));
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFF0a0a14),
        appBar: AppBar(
          backgroundColor: Color(0xFF1a1a2e),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF00F0FF)),
          title: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
            ).createShader(bounds),
            child: Text(
              "Detalle de Clase",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderClase(),

                const SizedBox(height: 20),

                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                  ).createShader(bounds),
                  child: Text(
                    "Actividades",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Expanded(child: build_Examenes(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderClase() {
    final clase = claseController.getclase;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00F0FF).withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(Icons.class_rounded, color: Colors.black, size: 30),
          ),
          const SizedBox(width: 16),

          /// muestra el nombre de la clase y el autor
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clase.nombre,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      color: Color(0xFF00FF41),
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      clase.autor,
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ////////////////////////////muestra el numero de actividades asignadas a la clase
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFF1a1a2e),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00FF41).withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
                border: Border.all(color: Color(0xFF00FF41), width: 1.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${examenes.length}",
                    style: TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Actividades",
                    style: TextStyle(
                      color: Color(0xFF00FF41),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
