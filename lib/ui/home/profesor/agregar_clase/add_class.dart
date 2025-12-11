import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/profesor/agregar_clase/widgets_add_clase/avatar_selector_card.dart';
import 'package:exa_gammer_movil/ui/home/profesor/agregar_clase/widgets_add_clase/clase_form_card.dart';
import 'package:exa_gammer_movil/ui/home/profesor/agregar_clase/widgets_add_clase/create_button.dart';
import 'package:exa_gammer_movil/ui/home/profesor/agregar_clase/widgets_add_clase/header_logo.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';

class AgregarClase extends StatefulWidget {
  const AgregarClase({super.key});

  @override
  State<AgregarClase> createState() => _AgregarClaseState();
}

class _AgregarClaseState extends State<AgregarClase> {
  final _formKey = GlobalKey<FormState>();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Usar addPostFrameCallback para ejecutar DESPUÉS del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeForm();
    });
  }

  void _initializeForm() {
    if (!_isInitialized) {
      final controller = Get.find<ClaseController>();
      final userController = Get.find<UserController>();
      final user = userController.getuser;

      // AHORA es seguro modificar los controladores
      controller.limpiarFormulario();
      controller.txtAutor.text = user.username;

      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClaseController());
    final userController = Get.find<UserController>();
    final user = userController.getuser;
    final token = userController.gettoken;
    controller.txtAutor.text = user.username;

    return Scaffold(
      backgroundColor: Color(0xFF0a0a14),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF00F0FF)),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ).createShader(bounds),
          child: const Text(
            'Nueva Clase',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              shadows: [Shadow(color: Color(0xFF00F0FF), blurRadius: 10)],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [
              Color(0xFF0a0a14),
              Color(0xFF16213e),
              Color(0xFF0a0a14),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const HeaderLogo(),
                const SizedBox(height: 32),

                _buildDecorativeLine(),
                const SizedBox(height: 24),

                ClaseFormCard(
                  txtNombre: controller.txtNombre,
                  txtTema: controller.txtTema,
                  txtAutor: controller.txtAutor,
                ),
                const SizedBox(height: 24),

                Obx(
                  () => AvatarSelectorCard(
                    avatarList: controller.avatarList,
                    avatarSeleccionado: controller.avatarSeleccionado.value,
                    mostrarAvatar: controller.mostrarAvatar.value,
                    onAvatarSelected: controller.seleccionarAvatar,
                  ),
                ),

                const SizedBox(height: 24),

                _buildDecorativeLine(),
                const SizedBox(height: 32),

                Obx(
                  () => CreateButton(
                    key: Key('btnCrearClase'),
                    isLoading: controller.isLoading.value,
                    onPressed: () =>
                        controller.crearClase(user, token, _formKey),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeLine() {
    return Container(
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Color(0xFF00F0FF).withOpacity(0.5),
            Color(0xFF00FF41).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
