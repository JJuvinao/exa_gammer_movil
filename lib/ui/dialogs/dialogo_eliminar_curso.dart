import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteCourseDialog extends StatelessWidget {
  const DeleteCourseDialog({super.key, required this.title});

  final title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text("Eliminar curso"),
      content: Text("¿Seguro que quieres borrar permanentemente\n\"$title\"?"),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text("Cancelar"),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          onPressed: () => Get.back(result: true),
          child: const Text("Borrar"),
        ),
      ],
    );
  }
}
