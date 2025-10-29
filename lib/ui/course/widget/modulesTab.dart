import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:exa_gammer_movil/ui/course/widget/lessonDialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModulesTab extends StatelessWidget {
  const ModulesTab({required this.curso});

  final Curso curso;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: curso.modules.length,
      itemBuilder: (context, i) {
        final modulo = curso.modules[i];
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
            children: modulo.lessons
                .map(
                  (leccion) => ListTile(
                    leading: Icon(Icons.article),
                    title: Text(leccion.title),
                    subtitle: Text(leccion.content.substring(0, 50) + '...'),
                    onTap: () {
                      Get.dialog(LessonDialog(lesson: leccion, course: curso));
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
