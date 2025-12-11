import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/juego_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:exa_gammer_movil/ui/home/widget/avatares.dart';
import '../widget/formahorcado.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/formheroes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/juego_controller.dart';

class AddExamen extends StatefulWidget {
  const AddExamen({super.key});

  @override
  State<AddExamen> createState() => _AddExamenState();
}

class _AddExamenState extends State<AddExamen> {
  final ExamenController actividadController = Get.find();
  final GlobalKey<AhorcadoFormState> ahorcadoFormKey =
      GlobalKey<AhorcadoFormState>();
  final GlobalKey<HeroesFormState> heroesFormKey = GlobalKey<HeroesFormState>();
  final UserController userController = Get.find();
  final ClaseController claseController = Get.find();
  final JuegoController juegoController = Get.find();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController temaController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var tiposJuego = <dynamic>[].obs;
  bool mostaravatar = false;
  String? selecionAvatar;

  final List<String> avatarList = [
    "assets/fondo/cieloatardecer.jpg",
    "assets/fondo/cieloazul.jpg",
    "assets/fondo/cielomorado.jpg",
    "assets/fondo/cielonoche.jpg",
    "assets/fondo/fondo1.jpg",
  ];

  @override
  void initState() {
    super.initState();
    tiposJuego.refresh();
    CargarJuego();
  }

  void CargarJuego() async {
    tiposJuego.value = await juegoController.getjuegoList();
  }

  @override
  Widget build(BuildContext context) {
    final Rxn<Juego> JuegoSeleccionado = Rxn<Juego>();

    return Scaffold(
      backgroundColor: Color(0xFF0a0a14),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF1a1a2e),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF00F0FF)),
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ).createShader(bounds),
          child: Text(
            "Agregar Examen",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
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
              colors: const [Color(0xFF1a1a2e), Color(0xFF16213e)],
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
            colors: const [
              Color(0xFF0a0a14),
              Color(0xFF16213e),
              Color(0xFF0a0a14),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 24),

                // Formulario principal
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [Color(0xFF1a1a2e), Color(0xFF16213e)],
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
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título del formulario
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: const [
                                    Color(0xFF00F0FF),
                                    Color(0xFF00FF41),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00F0FF).withOpacity(0.5),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.assignment_rounded,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: const [
                                  Color(0xFF00F0FF),
                                  Color(0xFF00FF41),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                'Nuevo Examen',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Nombre
                        _buildTextField(
                          controller: nombreController,
                          label: 'Nombre del Examen',
                          icon: Icons.edit_note_rounded,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingrese un nombre'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Tema
                        _buildTextField(
                          controller: temaController,
                          label: 'Tema',
                          icon: Icons.subject_rounded,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingrese un tema'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Descripción
                        _buildTextField(
                          controller: descripcionController,
                          label: 'Descripción',
                          icon: Icons.description_rounded,
                          maxLines: 3,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Ingrese una descripción'
                              : null,
                        ),
                        const SizedBox(height: 24),

                        // Avatar selector
                        _buildAvatarSelector(),
                        const SizedBox(height: 10),

                        // Tipo de Juego
                        _buildGameTypeDropdown(JuegoSeleccionado),
                        const SizedBox(height: 10),

                        // Formulario dinámico según el juego
                        Obx(() {
                          if (JuegoSeleccionado.value?.id == 1) {
                            return AhorcadoForm(key: ahorcadoFormKey);
                          }
                          if (JuegoSeleccionado.value?.id == 2) {
                            return HeroesForm(key: heroesFormKey);
                          }
                          return _buildSelectGameMessage();
                        }),
                        const SizedBox(height: 24),

                        // Mensaje informativo
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF00F0FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFF00F0FF).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xFF00F0FF),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Complete todos los campos y presione "Guardar Examen"',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Botón Guardar
                        _buildSaveButton(JuegoSeleccionado),
                      ],
                    ),
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [Color(0xFF1a1a2e), Color(0xFF16213e)],
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
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
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
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
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Color(0xFF00F0FF), size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF0a0a14).withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xFF00F0FF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Color(0xFF00F0FF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF00F0FF), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildAvatarSelector() {
    return Center(
      child: Column(
        children: [
          if (mostaravatar == true)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00F0FF).withOpacity(0.5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  selecionAvatar!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final avatar = await AvatarSelectorModal.show(
                  context,
                  avatarList,
                );
                if (avatar != null) {
                  setState(() {
                    selecionAvatar = avatar;
                    mostaravatar = true;
                  });
                }
              },
              icon: Icon(Icons.image_rounded, color: Colors.black),
              label: Text(
                'Elegir Avatar',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameTypeDropdown(Rxn<Juego> JuegoSeleccionado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.gamepad_rounded, color: Color(0xFF00FF41), size: 18),
            const SizedBox(width: 8),
            Text(
              'Tipo de Juego',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Obx(() {
          return DropdownButtonFormField<dynamic>(
            value: JuegoSeleccionado.value,
            dropdownColor: Color(0xFF1a1a2e),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFF0a0a14).withOpacity(0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color(0xFF00FF41).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color(0xFF00FF41).withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF00FF41), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
            ),
            items: tiposJuego.map((tipo) {
              return DropdownMenuItem(value: tipo, child: Text(tipo.nombre));
            }).toList(),
            onChanged: (value) {
              JuegoSeleccionado.value = value;
            },
            validator: (value) => value == null ? 'Seleccione un tipo' : null,
          );
        }),
      ],
    );
  }

  Widget _buildSelectGameMessage() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF0a0a14).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF00F0FF).withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.videogame_asset_rounded,
            color: Color(0xFF00F0FF).withOpacity(0.5),
            size: 40,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Seleccione un tipo de juego para continuar',
              style: TextStyle(fontSize: 15, color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(Rxn<Juego> JuegoSeleccionado) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF00F0FF).withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;

            Map<String, dynamic>? datos;

            if (JuegoSeleccionado.value?.id == 1) {
              datos = ahorcadoFormKey.currentState?.getData();
              if (datos == null || datos['listaAhorcado'].length < 5) {
                Get.snackbar(
                  'Error',
                  'Debe agregar al menos 5 palabras.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Color(0xFF1a1a2e),
                  colorText: Colors.red.shade300,
                  borderColor: Colors.red.withOpacity(0.5),
                  borderWidth: 1.5,
                  icon: Icon(Icons.error, color: Colors.red.shade300),
                  duration: const Duration(seconds: 3),
                  margin: EdgeInsets.all(16),
                  borderRadius: 12,
                );
                return;
              }
            }
            if (JuegoSeleccionado.value?.id == 2) {
              datos = heroesFormKey.currentState?.getData();
              if (datos == null || datos['lispreheroe'].length < 5) {
                Get.snackbar(
                  '❌ Error',
                  'Debe agregar al menos 5 preguntas.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Color(0xFF1a1a2e),
                  colorText: Colors.red.shade300,
                  borderColor: Colors.red.withOpacity(0.5),
                  borderWidth: 1.5,
                  icon: Icon(Icons.error, color: Colors.red.shade300),
                  duration: const Duration(seconds: 3),
                  margin: EdgeInsets.all(16),
                  borderRadius: 12,
                );
                return;
              }
            }

            Map<dynamic, dynamic> datosExamen = {};
            if (datos != null) {
              if (JuegoSeleccionado.value?.id == 2) {
                datosExamen = {'tipo': 'heroes', 'datos': datos};
              } else if (JuegoSeleccionado.value?.id == 1) {
                datosExamen = {'tipo': 'ahorcado', 'datos': datos};
              }
            }

            final examen = {
              'Nombre': nombreController.text,
              'Tema': temaController.text,
              'Autor': userController.getuser.username,
              'Descripcion': descripcionController.text,
              'ImagenExamen': "/avatars/avatar1.jpg",
              'Id_Clase': claseController.getclase.id,
              'Id_Juego': JuegoSeleccionado.value?.id,
            };

            var res = await actividadController.guardarExamen(
              examen,
              datosExamen,
              userController.gettoken,
            );

            if (res) {
              Get.snackbar(
                '✅ Examen Agregado',
                'El examen fue registrado exitosamente',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Color(0xFF1a1a2e),
                colorText: Color(0xFF00FF41),
                borderColor: Color(0xFF00FF41).withOpacity(0.5),
                borderWidth: 1.5,
                icon: Icon(Icons.check_circle, color: Color(0xFF00FF41)),
                duration: const Duration(seconds: 3),
                margin: EdgeInsets.all(16),
                borderRadius: 12,
              );
              Get.to(() => ClaseView(vista: "Clase"));
            } else {
              Get.snackbar(
                '❌ Error',
                'Hubo un problema al guardar el examen',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Color(0xFF1a1a2e),
                colorText: Colors.red.shade300,
                borderColor: Colors.red.withOpacity(0.5),
                borderWidth: 1.5,
                icon: Icon(Icons.error, color: Colors.red.shade300),
                duration: const Duration(seconds: 3),
                margin: EdgeInsets.all(16),
                borderRadius: 12,
              );
            }
          },
          icon: Icon(Icons.save_rounded, color: Colors.black, size: 24),
          label: Text(
            'Guardar Examen',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
