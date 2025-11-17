import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/dialogs/dialogo_ingresar_clase.dart';
import 'package:exa_gammer_movil/ui/home/buscar.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/logout_dialog.dart';

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

  @override
  void dispose() {
    filteredClase.clear();
    super.dispose();
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
        backgroundColor: const Color(0xFF0a0a14),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
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
                  // Header mejorado
                  _buildHeader(),
                  const SizedBox(height: 20),

                  // Buscador
                  BuscarClase(),
                  const SizedBox(height: 20),

                  // Título de sección con contador
                  _buildSectionTitle(),
                  const SizedBox(height: 16),

                  // Lista de clases
                  Expanded(
                    child: Obx(() {
                      if (filteredClase.isEmpty) {
                        return _buildEmptyState();
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: filteredClase.length,
                        itemBuilder: (context, index) {
                          final clase = filteredClase[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: _buildClaseCard(clase),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _buildFloatingButton(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00F0FF).withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo con efecto
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.5),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Image.asset('assets/imagen/logo_exa.png', height: 50),
          ),
          const SizedBox(width: 16),

          // Texto del título
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                  ).createShader(bounds),
                  child: Text(
                    'EXA-GAMMER',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TitanOne",
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
                const SizedBox(height: 4),
                Text(
                  'Estudiante',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
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
            shadows: [Shadow(color: Color(0xFF00F0FF), blurRadius: 10)],
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

  Widget _buildClaseCard(dynamic clase) {
    return GestureDetector(
      onTap: () {
        pc.saveClase(clase);
        Get.to(() => ClaseView(vista: "Clase"));
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF00F0FF).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF00F0FF).withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Imagen de fondo
              if (clase.img != null && clase.img.isNotEmpty)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.7,
                    child: Image.network(
                      clase.img,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Color(0xFF16213e));
                      },
                    ),
                  ),
                ),

              // Overlay con gradiente
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF1a1a2e).withOpacity(0.7),
                        Color(0xFF16213e).withOpacity(0.9),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),

              // Contenido
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icono decorativo
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00F0FF).withOpacity(0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.class_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Información
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            clase.nombre,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Color(0xFF00F0FF).withOpacity(0.5),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.person_rounded,
                                size: 14,
                                color: Color(0xFF00FF41),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  clase.autor ?? 'Sin autor',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Flecha
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFF00F0FF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFF00F0FF).withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xFF00F0FF),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00F0FF).withOpacity(0.1),
                  Color(0xFF00FF41).withOpacity(0.1),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFF00F0FF).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.school_outlined,
              size: 80,
              color: Color(0xFF00F0FF).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 24),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
            ).createShader(bounds),
            child: Text(
              'No hay clases registradas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Únete a una clase usando el código',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00F0FF).withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () async {
          final result = await IngresarCodigo(context);
          print("resultado del dialogo: $result");
          if (result == true) {
            CargarClase();
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: Icon(Icons.add_rounded, color: Colors.black, size: 24),
        label: Text(
          'Unirse',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
