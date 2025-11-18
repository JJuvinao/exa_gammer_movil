import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/ui/calificacion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resultados extends StatefulWidget {
  Resultados({super.key});

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

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 2,
            child: ListTile(
              title: Text(
                "Estudiante: ${result.Nombre}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onTap: () => {Get.to(() => CalificarExam(resultado: result))},
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Correo: ${result.correo}'),
                  const SizedBox(height: 4),
                  Text('Notas: ${result.nota ?? '0.0'} / 5.0'),
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
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Resultados del examen",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: build_Resultados(context),
        ),
      ),
    );
  }
}
