import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:exa_gammer_movil/ui/home/widget/ClaseCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';
import 'package:exa_gammer_movil/ui/home/profesor/add_clase.dart';

class HomeProfesor extends StatefulWidget {
  HomeProfesor({super.key});

  @override
  State<HomeProfesor> createState() => _HomeProfesorState();
}

class _HomeProfesorState extends State<HomeProfesor> {
  late final ClaseController claseController;
  late final UserController userController;

  var filteredClase = <dynamic>[].obs;

  @override
  void initState() {
    super.initState();
    claseController = Get.find<ClaseController>();
    userController = Get.find<UserController>();

    CargarClase();
  }

  @override
  void dispose() {
    super.dispose();
    filteredClase.clear();
    claseController.logoutClase();
  }

  void CargarClase() async {
    final user = userController.getuser;
    final token = userController.gettoken;
    filteredClase.value = await claseController.filteredList(
      user.id,
      token,
      user.rol,
    );
  }

  Widget build_Clases(BuildContext context) {
    return Obx(() {
      if (filteredClase.isEmpty) {
        return const Center(
          child: Text(
            'No hay clases registradas.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }
      return LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 800
              ? 4
              : constraints.maxWidth > 600
              ? 3
              : 2;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredClase.length,
            itemBuilder: (context, index) {
              final clase = filteredClase[index];
              return ObjetoCard(
                titulo: clase.nombre,
                imagenUrl: clase.img,
                onTap: () {
                  claseController.saveClase(clase);
                  Get.to(() => ClaseView(vista: "Clase"));
                },
              );
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  Image.asset('assets/imagen/logo_exa.png', height: 75),
                  const SizedBox(width: 12),
                  const Text(
                    'EXA-GAMMER',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TitanOne",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BuscarClase(),
              const SizedBox(height: 10),
              Expanded(child: build_Clases(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => Agregarclase());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
