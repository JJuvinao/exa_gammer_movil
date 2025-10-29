import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/ui/home/widget/listaperso.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Estud_Clase extends StatefulWidget {
  Estud_Clase({super.key});

  @override
  State<Estud_Clase> createState() => _Estud_ClaseState();
}

class _Estud_ClaseState extends State<Estud_Clase> {
  final ClaseController pc = Get.find();
  final UserController user = Get.find<UserController>();
  var users = <User>[].obs;

  @override
  void initState() {
    super.initState();
    CargarUser_Clase();
  }

  void CargarUser_Clase() async {
    final clase = pc.getclase;
    final token = user.gettoken;
    users.value = await pc.CargarUser_Clase(clase.id, token);
    print(users[0].username);
    print(users[0].email);
  }

  Widget build_Clases(BuildContext context) {
    return Obx(() {
      if (users.isEmpty) {
        return const Center(
          child: Text(
            'No hay estudiantes registrados en la clase.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }
      return Listaperso(users: users);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Estudiantes de la clase",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Expanded(child: build_Clases(context)),
    );
  }
}
