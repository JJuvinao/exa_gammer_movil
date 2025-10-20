import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/game/ahorcado/ahorcado_controller.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exa_gammer_movil/ui/app.dart';
import 'package:exa_gammer_movil/controllers/juego_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  Get.put(ClaseController());
  Get.put(UserController());
  Get.put(JuegoController());
  Get.put(ExamenController());
  Get.put(AhorcadoController());
  Get.put(CursoController());

  runApp(MyApp());
}
