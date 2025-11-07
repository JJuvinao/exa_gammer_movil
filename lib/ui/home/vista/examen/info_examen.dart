import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Info_Examen extends StatefulWidget {
  Info_Examen({super.key});

  @override
  State<Info_Examen> createState() => _Info_ExamenState();
}

class _Info_ExamenState extends State<Info_Examen> {
  final ExamenController pc = Get.find();
  late final UserController user = Get.find<UserController>();
  var examen;

  @override
  void initState() {
    super.initState();
    examen = pc.getexamen;
  }

  void _copiarCodigo() {
    Clipboard.setData(ClipboardData(text: examen.codigo));
    Get.snackbar(
      '✅ Código Copiado',
      'El código del examen ha sido copiado al portapapeles',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF1a1a2e),
      colorText: Color(0xFF00FF41),
      borderColor: Color(0xFF00FF41).withOpacity(0.5),
      borderWidth: 1.5,
      icon: Icon(Icons.check_circle, color: Color(0xFF00FF41)),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void _editarExamen() {
    // TODO: Implementar lógica para editar examen
    Get.snackbar(
      '✏️ Editar Examen',
      'Función en desarrollo',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xFF1a1a2e),
      colorText: Color(0xFF00F0FF),
      borderColor: Color(0xFF00F0FF).withOpacity(0.5),
      borderWidth: 1.5,
      icon: Icon(Icons.edit, color: Color(0xFF00F0FF)),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void _eliminarExamen() async {
    final confirmar = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: Color(0xFF1a1a2e),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Colors.red.withOpacity(0.5),
            width: 2,
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red.shade400, Colors.red.shade600],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.warning_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            Text(
              '¿Eliminar Examen?',
              style: TextStyle(
                color: Colors.red.shade300,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar "${examen.nombre}"?\n\nEsta acción no se puede deshacer.',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[400],
            ),
            child: const Text('Cancelar'),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade400, Colors.red.shade600],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
              child: const Text(
                'Eliminar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      // TODO: Implementar lógica para eliminar examen del servidor
      Get.snackbar(
        '🗑️ Examen Eliminado',
        'El examen ha sido eliminado exitosamente',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color(0xFF1a1a2e),
        colorText: Colors.red.shade300,
        borderColor: Colors.red.withOpacity(0.5),
        borderWidth: 1.5,
        icon: Icon(Icons.delete, color: Colors.red.shade300),
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(16),
        borderRadius: 12,
      );
      // Get.back(); // Volver a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0a14),
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a2e),
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ).createShader(bounds),
          child: Text(
            "Información del Examen",
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
              colors: [
                Color(0xFF1a1a2e),
                Color(0xFF16213e),
              ],
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
            colors: [
              Color(0xFF0a0a14),
              Color(0xFF16213e),
              Color(0xFF0a0a14),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Card principal de información
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1a1a2e),
                      Color(0xFF16213e),
                    ],
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
                child: Column(
                  children: [
                    // Logo
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00F0FF).withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/imagen/logo_exa.png',
                        height: 70,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Nombre del examen
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                      ).createShader(bounds),
                      child: Text(
                        examen.nombre,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: "TitanOne",
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Color(0xFF00F0FF),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Divider decorativo
                    Container(
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
                    ),

                    const SizedBox(height: 24),

                    // Tema
                    _buildInfoRow(
                      Icons.book_rounded,
                      "Tema",
                      examen.tema,
                      Color(0xFF00F0FF),
                    ),

                    const SizedBox(height: 16),

                    // Autor
                    _buildInfoRow(
                      Icons.person_rounded,
                      "Autor",
                      examen.autor,
                      Color(0xFF00FF41),
                    ),

                    const SizedBox(height: 16),

                    // Código
                    _buildCodigoRow(),

                    const SizedBox(height: 16),

                    // Descripción
                    _buildDescripcionRow(),
                  ],
                ),
              ),

              // Botones de acción (solo para profesores)
              if (user.getuser.rol == "Profesor") ...[
                const SizedBox(height: 24),

                // Botones Editar y Eliminar
                Row(
                  children: [
                    // Botón Editar
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.edit_rounded,
                        label: "Editar",
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00F0FF),
                            Color(0xFF00FF41),
                          ],
                        ),
                        glowColor: Color(0xFF00F0FF),
                        onPressed: _editarExamen,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Botón Eliminar
                    Expanded(
                      child: _buildActionButton(
                        icon: Icons.delete_rounded,
                        label: "Eliminar",
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.shade400,
                            Colors.red.shade600,
                          ],
                        ),
                        glowColor: Colors.red,
                        onPressed: _eliminarExamen,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCodigoRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF00FF41).withOpacity(0.1),
            Color(0xFF00F0FF).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF00FF41).withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00FF41), Color(0xFF00F0FF)],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00FF41).withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(Icons.code_rounded, color: Colors.black, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Código del Examen",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  examen.codigo,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF00FF41),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: Color(0xFF00FF41).withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _copiarCodigo,
            icon: Icon(Icons.copy_rounded, color: Color(0xFF00FF41)),
            tooltip: 'Copiar código',
          ),
        ],
      ),
    );
  }

  Widget _buildDescripcionRow() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF00F0FF).withOpacity(0.1),
            Color(0xFF00FF41).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00F0FF).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child:
                    Icon(Icons.description_rounded, color: Colors.black, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                "Descripción",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            examen.descripcion,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required LinearGradient gradient,
    required Color glowColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.4),
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
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black, size: 22),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}