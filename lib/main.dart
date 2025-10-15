import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/actividad_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  Get.put(ClaseController());
  Get.put(UserController());
  Get.put(ExamenController());
  runApp(MyApp());
}
