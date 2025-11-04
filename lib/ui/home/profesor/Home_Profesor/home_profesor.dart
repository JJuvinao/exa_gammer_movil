import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';
import 'package:exa_gammer_movil/ui/home/profesor/agregar_clase/add_class.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/clases_list_view.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/fab_nueva_clase.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/header_home.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/logout_dialog.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';

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
    _cargarClase();
  }

  @override
  void dispose() {
    filteredClase.clear();
    claseController.logoutClase();
    super.dispose();
  }

  void _cargarClase() async {
    final user = userController.getuser;
    final token = userController.gettoken;

    filteredClase.value = await claseController.filteredList(
      user.id,
      token,
      user.rol,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldLogout = await showLogoutDialog(context);
        if (shouldLogout == true) {
          await userController.logout();
          Get.offAll(() => Vistalogin());
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0a0a14),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0a0a14),
                Color(0xFF16213e),
                Color(0xFF0a0a14),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderHome(),
                  const SizedBox(height: 20),
                  BuscarClase(),
                  const SizedBox(height: 20),
                  _buildSectionTitle(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ClasesListView(
                      filteredClase: filteredClase,
                      claseController: claseController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FabNuevaClase(
          onPressed: () => Get.to(() => AgregarClase()),
        ),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Mis Clases',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00F0FF),
            shadows: [
              Shadow(
                color: Color(0xFF00F0FF),
                blurRadius: 10,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00FF41).withOpacity(0.3),
                  Color(0xFF00F0FF).withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Color(0xFF00FF41).withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Text(
              '${filteredClase.length}',
              style: const TextStyle(
                color: Color(0xFF00FF41),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
