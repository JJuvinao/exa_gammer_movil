import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Estud_Clase extends StatelessWidget {
  final ClaseController pc = Get.find();

  Estud_Clase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(child: Text('Estudiantes de la Clase')),
    );
  }
}
