/*import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:exa_gammer_movil/ui/home/widget/avatares.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';

class Agregarclase extends StatefulWidget {
  const Agregarclase({super.key});

  @override
  State<Agregarclase> createState() => _AgregarclaseState();
}

class _AgregarclaseState extends State<Agregarclase> {
  final ClaseController pc = Get.find();
  final UserController usercontroller = Get.find<UserController>();
  final TextEditingController txtNombre = TextEditingController();
  final TextEditingController txtTema = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool mostaravatar = false;
  String? selecionAvatar;
  bool isLoading = false;

  final List<String> avatarList = [
    "assets/fondo/cieloatardecer.jpg",
    "assets/fondo/cieloazul.jpg",
    "assets/fondo/cielomorado.jpg",
    "assets/fondo/cielonoche.jpg",
    "assets/fondo/fondo1.jpg",
  ];

  @override
  void dispose() {
    txtNombre.dispose();
    txtTema.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = usercontroller.getuser;
    var token = usercontroller.gettoken;
    final TextEditingController txtAutor = TextEditingController(
      text: user.username,
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nueva Clase',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo y título
                _buildHeader(),
                const SizedBox(height: 32),

                // Card principal del formulario
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título de la sección
                      const Text(
                        'Información de la clase',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D59A1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Completa los datos para crear una nueva clase',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Campo Nombre
                      _buildTextFieldMejorado(
                        controller: txtNombre,
                        label: 'Nombre de la clase',
                        hint: 'Ej: Matemáticas Avanzadas',
                        icon: Icons.school_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el nombre de la clase';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo Tema
                      _buildTextFieldMejorado(
                        controller: txtTema,
                        label: 'Tema',
                        hint: 'Ej: Álgebra Lineal',
                        icon: Icons.topic_rounded,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el tema';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo Autor (readonly)
                      _buildTextFieldMejorado(
                        controller: txtAutor,
                        label: 'Profesor',
                        icon: Icons.person_rounded,
                        enabled: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sección de avatar
                _buildAvatarSection(),

                const SizedBox(height: 32),

                // Botón crear clase
                _buildCreateButton(user, token, txtAutor),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(
            'assets/imagen/logo_exa.png',
            height: 40,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'EXA-GAMMER',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: "TitanOne",
            color: Color(0xFF0D59A1),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldMejorado({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF0D59A1),
        ),
        filled: true,
        fillColor: enabled ? Colors.grey[50] : Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0D59A1), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red[300]!, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Imagen de la clase',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D59A1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Selecciona una imagen representativa',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),

          // Previsualización del avatar
          if (mostaravatar && selecionAvatar != null)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0D59A1).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  selecionAvatar!,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Icon(
                Icons.image_rounded,
                size: 50,
                color: Colors.grey[400],
              ),
            ),

          const SizedBox(height: 24),

          // Botón elegir avatar
          OutlinedButton.icon(
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
            icon: const Icon(Icons.photo_library_rounded),
            label: Text(mostaravatar ? 'Cambiar imagen' : 'Seleccionar imagen'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0D59A1),
              side: const BorderSide(color: Color(0xFF0D59A1), width: 2),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(user, token, TextEditingController txtAutor) {
    return ElevatedButton(
      onPressed: isLoading ? null : () => _crearClase(user, token, txtAutor),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D59A1),
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey[400],
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        shadowColor: const Color(0xFF0D59A1).withOpacity(0.5),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, size: 24),
                SizedBox(width: 12),
                Text(
                  'Crear clase',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _crearClase(user, token, TextEditingController txtAutor) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selecionAvatar == null) {
      Get.snackbar(
        'Imagen requerida',
        'Por favor selecciona una imagen para la clase',
        backgroundColor: Colors.orange[700],
        colorText: Colors.white,
        icon: const Icon(Icons.warning_rounded, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      Clasedto newclase = Clasedto(
        nombre: txtNombre.text,
        tema: txtTema.text,
        autor: txtAutor.text,
        imagenClase: selecionAvatar!,
        id_Profe: user.id,
      );

      var res = await pc.AddClase(newclase, token);

      if (res == true) {
        Get.snackbar(
          '¡Éxito!',
          'La clase se creó correctamente',
          backgroundColor: Colors.green[600],
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        Get.off(() => MainView(vista: "Profesor"));
      } else {
        throw Exception('Error al crear la clase');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo crear la clase. Inténtalo de nuevo',
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
        icon: const Icon(Icons.error_rounded, color: Colors.white),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
} */