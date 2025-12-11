import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:exa_gammer_movil/ui/course/courseContentView.dart';
import 'package:exa_gammer_movil/ui/dialogs/dialogo_eliminar_curso.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class courseScreen extends StatefulWidget {
  const courseScreen({super.key});

  @override
  State<courseScreen> createState() => _courseScreenState();
}

class _courseScreenState extends State<courseScreen> {
  final CursoController controller = Get.put(CursoController());

  @override
  void initState() {
    super.initState();
    controller.fetchCursos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 20),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 10, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
          side: BorderSide(color: const Color.fromARGB(255, 77, 0, 110)),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Mis Cursos',
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchCursos,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0a0a14),
                  Color(0xFF16213e),
                  Color(0xFF0a0a14),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (controller.cursoList.isEmpty) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0a0a14),
                  Color(0xFF16213e),
                  Color(0xFF0a0a14),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text(
                "No tienes cursos aún\n¡Genera uno nuevo!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          );
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: ListView.builder(
              itemCount: controller.cursoList.length,
              itemBuilder: (context, index) {
                final curso = controller.cursoList[index];
                return Card(
                  elevation: 5,
                  shadowColor: Colors.greenAccent,
                  color: const Color.fromARGB(255, 25, 25, 51),
                  child: ListTile(
                    title: Text(
                      curso.title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 173, 173, 173),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${curso.description.substring(0, 50)}...',
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: LinearProgressIndicator(
                            value: curso.percentage / 100,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: curso.completed
                          ? Colors.green
                          : Colors.blue[700],
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final confirm = await Get.dialog(
                          DeleteCourseDialog(title: curso.title),
                        );
                        if (confirm) {
                          await controller.DeleteCurso(curso.id_curso);
                          Get.snackbar(
                            "Eliminado",
                            "${curso.title} fue borrado",
                            backgroundColor: Colors.red[400],
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                      tooltip: "Borrar curso",
                    ),
                    onTap: () => _mostrarDetalle(curso),
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _generarNuevoCurso();
          await controller.fetchCursos();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _generarNuevoCurso() async {
    Get.dialog(
      AlertDialog(
        title: Text('Generar Nuevo Curso'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Escribe el tema...'),
          onSubmitted: (tema) async {
            Get.back();
            await controller.generateCurso(tema);
          },
        ),
      ),
    );
  }

  void _mostrarDetalle(Curso curso) {
    controller.CourseSelect(curso);
    Get.to(() => Coursecontentview());
  }
}
