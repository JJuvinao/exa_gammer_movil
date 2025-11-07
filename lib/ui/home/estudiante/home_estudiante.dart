import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/course/courseView.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/logout_dialog.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:exa_gammer_movil/ui/home/widget/ClaseCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/dialogs/dialogo_ingresar_clase.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';

class HomeEstudiante extends StatefulWidget {
  HomeEstudiante({super.key});

  @override
  State<HomeEstudiante> createState() => _HomeEstudianteState();
}

class _HomeEstudianteState extends State<HomeEstudiante> {
  final ClaseController pc = Get.find();

  final UserController usercontroller = Get.find<UserController>();
  var filteredClase = <dynamic>[].obs;

  @override
  void initState() {
    super.initState();
    CargarClase();
  }

  void CargarClase() async {
    final user = usercontroller.getuser;
    final token = usercontroller.gettoken;
    filteredClase.value = await pc.filteredList(user.id, token, user.rol);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldLogout = await showLogoutDialog(context);
        if (shouldLogout == true) {
          await usercontroller.logout();
          Get.offAll(() => Vistalogin());
        }
        return false;
      },
      child: Scaffold(
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
                // Encabezado con logo y texto
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

                Expanded(
                  child: Obx(() {
                    if (filteredClase.isEmpty) {
                      return const Center(
                        child: Text(
                          'No hay clases registradas.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      itemCount: filteredClase.length,
                      itemBuilder: (context, index) {
                        final clase = filteredClase[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SizedBox(
                            height: 120,
                            width: double.infinity,
                            child: ObjetoCard(
                              titulo: clase.nombre,
                              imagenUrl: clase.img,
                              onTap: () {
                                pc.saveClase(clase);
                                Get.to(() => ClaseView(vista: "Clase"));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () async {
                final result = await IngresarCodigo(context);
                print("resultado del dialogo: $result");
                if (result == true) {
                  CargarClase();
                }
              },
              child: const Icon(Icons.meeting_room),
            ),
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                Get.to(() => courseScreen());
              },
              child: const Icon(Icons.school),
            ),
          ],
        ),
      ),
    );
  }
}
