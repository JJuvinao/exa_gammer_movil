import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:exa_gammer_movil/ui/course/courseContentView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class courseScreen extends StatelessWidget {
  courseScreen({super.key});

  final CursoController controller = Get.put(CursoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Mis Cursos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchCursos,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: controller.cursoList.length,
          itemBuilder: (context, index) {
            final curso = controller.cursoList[index];
            return Card(
              child: ListTile(
                title: Text(curso.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${curso.description.substring(0, 50)}...'),
                    LinearProgressIndicator(value: curso.Percentage / 100),
                  ],
                ),
                trailing: Icon(
                  curso.Completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: curso.Completed ? Colors.green : Colors.grey,
                ),
                onTap: () => _mostrarDetalle(curso),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generarNuevoCurso(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _generarNuevoCurso() {
    Get.dialog(
      AlertDialog(
        title: Text('Generar Nuevo Curso'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Escribe el tema...'),
          onSubmitted: (tema) {
            controller.generateCurso(tema);
            Get.back();
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
