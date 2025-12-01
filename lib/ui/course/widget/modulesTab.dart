import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/leccion_model.dart';
import 'package:exa_gammer_movil/ui/course/widget/lessonDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModulesTab extends StatelessWidget {
  ModulesTab({super.key});

  final CursoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final curso = controller.selectedCurso!.value;
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: curso.modules.length,
      itemBuilder: (context, i) {
        final modulo = curso.modules[i];
        return GetBuilder<CursoController>(
          id: "Modules",
          builder: (ctrl) {
            return Card(
              elevation: 5,
              shadowColor: Colors.deepPurpleAccent,
              color: const Color.fromARGB(255, 25, 25, 51),
              margin: EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(
                  modulo.title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 173, 173, 173),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '${modulo.lessons.length} lecciones',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  modulo.Completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: modulo.Completed ? Colors.green : Colors.grey,
                ),
                children: modulo.lessons.asMap().entries.map((entry) {
                  final LeccionModel leccion = entry.value;
                  final int index = entry.key;
                  return ListTile(
                    tileColor: leccion.completed
                        ? const Color.fromARGB(255, 67, 46, 94)
                        : const Color.fromARGB(255, 39, 39, 79),
                    leading: Icon(
                      Icons.article,
                      color: leccion.completed
                          ? const Color.fromARGB(255, 133, 255, 120)
                          : Colors.grey,
                    ),
                    title: Text(
                      leccion.title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 173, 173, 173),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '${leccion.content.substring(0, 50)}...',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.dialog(
                        LessonDialog(
                          lessonIndex: index,
                          lesson: leccion,
                          module: modulo,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
