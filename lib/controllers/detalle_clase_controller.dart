//totalmente nuevo..... no se que tan necesisario sea

import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class DetalleClaseController extends GetxController {
  final examenController = Get.put(ExamenController());
  final claseController = Get.find<ClaseController>();
  final userController = Get.find<UserController>();

  var examenesList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    cargarExamenes();
  }

  Future<void> cargarExamenes() async {
    final clase = claseController.getclase;
    final token = userController.gettoken;
    examenesList.value = await examenController.filteredList(clase.id, token);
  }
}
