//totalmente nuevo..... no se que tan necesisario sea

import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class DetalleClaseController extends GetxController {
  late final examenController;
  late final claseController;
  late final userController;

  var examenesList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    examenController = Get.put(ExamenController());
    claseController = Get.find<ClaseController>();
    userController = Get.find<UserController>();
    cargarExamenes();
  }

  Future<dynamic> cargarExamenes() async {
    final clase = claseController.getclase;
    final token = userController.gettoken;
    return examenesList.value = await examenController.filteredList(
      clase.id,
      token,
    );
  }
}
