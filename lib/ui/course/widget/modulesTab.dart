import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/leccion_model.dart';
import 'package:exa_gammer_movil/ui/course/widget/lessonDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModulesTab extends StatelessWidget {
  ModulesTab();

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
              margin: EdgeInsets.only(bottom: 12),
              child: ExpansionTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text(modulo.title),
                subtitle: Text('${modulo.lessons.length} lecciones'),
                trailing: Icon(
                  modulo.Completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                ),
                children: modulo.lessons.asMap().entries.map((entry) {
                  final LeccionModel leccion = entry.value;
                  final int index = entry.key;
                  return ListTile(
                    tileColor: leccion.Completed
                        ? const Color.fromARGB(255, 201, 255, 190)
                        : Colors.white,
                    leading: Icon(Icons.article),
                    title: Text(leccion.title),
                    subtitle: Text(leccion.content.substring(0, 50) + '...'),
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
