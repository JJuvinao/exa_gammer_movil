import 'package:exa_gammer_movil/models/actividad_model.dart';
import 'package:get/get.dart';

class ActividadController extends GetxController {
  var actividadList = <Actividad>[].obs;

  void addActividad(Actividad actividad) {
    actividadList.add(actividad);
  }

  void deleteActividad(int index) {
    actividadList.removeAt(index);
  }

  void clearActividades() {
    actividadList.clear();
  }
}
