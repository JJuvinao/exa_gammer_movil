import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:exa_gammer_movil/models/CursoModel/leccion_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonDialog extends StatelessWidget {
  const LessonDialog({super.key, required this.lesson, required this.course});

  final LeccionModel lesson;
  final Curso course;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
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
                  onPressed: () => Get.back(),
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
              flex: 0,
            ),
          ],
        ),
      ),
    );
  }
}
