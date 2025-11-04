import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Info_Examen extends StatefulWidget {
  Info_Examen({super.key});

  @override
  State<Info_Examen> createState() => _Info_ExamenState();
}

class _Info_ExamenState extends State<Info_Examen> {
  final ExamenController pc = Get.find();
  late final UserController user = Get.find<UserController>();
  var examen;

  @override
  void initState() {
    super.initState();
    examen = pc.getexamen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Información del examen",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/imagen/logo_exa.png', height: 80),
                  const SizedBox(height: 20),

                  Text(
                    examen.nombre,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TitanOne",
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(Icons.book, color: Colors.deepPurple),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Tema: ${examen.tema}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.teal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Autor: ${examen.autor}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.add_box_rounded, color: Colors.teal),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Codigo: ${examen.codigo}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.description,
                                  color: Colors.teal,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Descripción:",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${examen.descripcion}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
