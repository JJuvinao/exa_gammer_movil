import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
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
  }

  Widget build_Clases(BuildContext context) {
    return Obx(() {
      if (users.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00F0FF).withOpacity(0.2),
                      Color(0xFF00FF41).withOpacity(0.2),
                    ],
                  ),
                  border: Border.all(
                    color: Color(0xFF00F0FF).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.people_outline_rounded,
                  size: 60,
                  color: Color(0xFF00F0FF),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'No hay estudiantes registrados en la clase.',
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      return Listaperso(users: users);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.to(MainView(vista: user.getuser.rol)),
      child: Scaffold(
        backgroundColor: Color(0xFF0a0a14),
        appBar: AppBar(
          backgroundColor: Color(0xFF1a1a2e),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
            ).createShader(bounds),
            child: Text(
              "Estudiantes de la clase",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Color(0xFF00F0FF).withOpacity(0.5),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFF00F0FF).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(children: [Expanded(child: build_Clases(context))]),
        ),
      ),
    );
  }
}
