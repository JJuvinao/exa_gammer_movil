import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/leccion_model.dart';
import 'package:exa_gammer_movil/models/CursoModel/modulo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonDialog extends StatelessWidget {
  LessonDialog({
    super.key,
    required this.lessonIndex,
    required this.lesson,
    required this.module,
  });

  final int lessonIndex;
  final LeccionModel lesson;
  final ModuloModel module;
  final CursoController controller = Get.find();

  void _NextDialog(BuildContext context) {
    int listLength = module.lessons.length;
    int nextIndex = lessonIndex + 1;
    Get.back();
    if (nextIndex < listLength) {
      Get.dialog(
        LessonDialog(
          lessonIndex: nextIndex,
          lesson: module.lessons[nextIndex],
          module: module,
        ),
      );
    }
  }

  void _ShowSnackbar(String title) {
    Get.snackbar(
      "Lección completada",
      "Has completado la lección: $title",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 16,
      child: Container(
        padding: EdgeInsets.all(20),
        constraints: BoxConstraints(maxHeight: Get.height * 0.6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.book, color: Colors.blue[700]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    if (!lesson.Completed) {
                      lesson.Completed = true;
                      controller.CompleteModule(module);
                    }
                    Get.back();
                  },
                ),
              ],
            ),
            Divider(height: 20, thickness: 1),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  lesson.content,
                  style: TextStyle(fontSize: 16, height: 1.6),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: lesson.Completed
                    ? null
                    : () {
                        lesson.Completed = true;
                        controller.CompleteModule(module);
                        _NextDialog(context);
                        _ShowSnackbar(lesson.title);
                      },
                icon: Icon(lesson.Completed ? Icons.check_circle : Icons.check),
                label: Text(
                  lesson.Completed ? "Completada" : "Siguiente lección",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: lesson.Completed
                      ? Colors.grey
                      : Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
