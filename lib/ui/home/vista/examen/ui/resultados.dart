import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/ui/calificacion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  late final UserController user;
  late final ExamenController exam;
  var resultados = <Estudi_Resultados>[].obs;

  @override
  void initState() {
    super.initState();
    user = UserController();
    exam = ExamenController();
    cargarContenido();
  }

  void cargarContenido() async {
    resultados.value = await exam.listresult(
      user.getuser.id,
      exam.getexamen.id,
      user.gettoken,
    );
  }

  Widget build_Resultados(BuildContext context) {
    return Obx(() {
      if (resultados.isEmpty) {
        return const Center(
          child: Text(
            'No hay actividades registradas.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.builder(
        itemCount: resultados.length,
        itemBuilder: (context, index) {
          final result = resultados[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
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
              title: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                ).createShader(bounds),
                child: Text(
                  "Estudiante: ${result.Nombre}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () => {Get.to(() => CalificarExam(resultado: result))},
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'Correo: ${result.correo}',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Notas: ${result.nota ?? '0.0'} / 5.0',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  const SizedBox(height: 4),
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
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14), // Fondo oscuro
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e), // Color oscuro para la AppBar
        elevation: 0,
        iconTheme: IconThemeData(color: const Color(0xFF00F0FF)),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ).createShader(bounds),
          child: const Text(
            "Resultados del examen",
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
          padding: const EdgeInsets.all(24.0),
          child: build_Resultados(context),
        ),
      ),
    );
  }
}
