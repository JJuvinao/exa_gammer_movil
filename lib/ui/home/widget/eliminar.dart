import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

void deleteClase({required BuildContext context, required int index}) {
  final ClaseController pc = Get.find();
  final clase = pc.claseList[index];

  Get.defaultDialog(
    title: 'Eliminar clase',
    middleText: '¿Estás seguro de que deseas eliminar la clase "${clase.nombre}"?',
    textCancel: 'Cancelar',
    textConfirm: 'Eliminar',
    confirmTextColor: Colors.white,
    onConfirm: () {
      pc.claseList.removeAt(index);
      pc.claseList.refresh();
      Get.back();

      Get.snackbar(
        'Clase eliminada',
        '${clase.nombre} ha sido eliminada correctamente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
      );
    },
  );
}
