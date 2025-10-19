import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/vista/ClaseCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';
import 'package:exa_gammer_movil/ui/home/profesor/add_clase.dart';
import 'package:exa_gammer_movil/ui/home/profesor/detalle_clase.dart';
import 'package:exa_gammer_movil/ui/home/vista/profile_view.dart'; 

class HomeProfesor extends StatelessWidget {
  final ClaseController pc = Get.find();
  final UserController usercontroller = Get.find<UserController>();

  HomeProfesor({super.key});

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

              const SizedBox(height: 10),

              // 🔹 Botón que lleva al perfil
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // 👇 Abre directamente la vista de perfil
                    Get.to(() => ProfileView());
                  },
                  icon: const Icon(Icons.person),
                  label: const Text("Mi perfil"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              BuscarClase(),

              const SizedBox(height: 10),

              Expanded(
                child: Obx(() {
                  final user = usercontroller.getuser;
                  final token = usercontroller.gettoken;
                  var filteredClase = pc.filteredList(user.id, token);

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
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
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
                              Get.to(() => DetalleClase());
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ),
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




