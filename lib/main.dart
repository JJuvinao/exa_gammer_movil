import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/actividad_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/app.dart';


void main() {
  Get.put(ClaseController());
  Get.put(UserController());
  Get.put(ActividadController());
  runApp(MyApp());
}
