import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listPalab_Res.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listPregun_Res.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CalificarExam extends StatefulWidget {
  final Estudi_Resultados resultado;

  const CalificarExam({super.key, required this.resultado});

  @override
  State<CalificarExam> createState() => _CalificarExamState();
}

class _CalificarExamState extends State<CalificarExam> {
  final TextEditingController recomendacionController = TextEditingController();
  final TextEditingController notaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ExamenController exacontroller = Get.find();
  final UserController user = Get.find();
  List<Heroes> listher = [];
  List<Ahorcado> listahorcado = [];

  bool editar = false;

  @override
  void initState() {
    super.initState();
    if (exacontroller.getexamen.id_juego == 2) {
      cargarListaHeroes();
    } else {
      cargarListaAhorcado();
    }
  }

  void cargarListaHeroes() {
    listher = exacontroller.getcontextheroes;
  }

  void cargarListaAhorcado() {
    listahorcado = exacontroller.getcontextahorcadoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14),
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a2e),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF00F0FF)),
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ).createShader(bounds),
          child: Text(
            "Calificar Examen",
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Información del estudiante
                      _buildInfoCard(
                        title: "Información del Estudiante",
                        icon: Icons.person_rounded,
                        body: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                              "Nombre",
                              widget.resultado.Nombre,
                              Icons.badge_rounded,
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              "Correo",
                              widget.resultado.correo,
                              Icons.email_rounded,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Respuestas del examen
                      _buildRespuestasSection(),
                      const SizedBox(height: 20),

                      // Nota
                      _buildNotaCard(),
                      const SizedBox(height: 20),

                      // Recomendación
                      _buildRecomendacionCard(),
                      const SizedBox(height: 24),

                      // Botón Guardar
                      _buildSaveButton(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
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
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
              ).createShader(bounds),
              child: Text(
                'Calificar Examen',
                style: TextStyle(
                  fontSize: 24,
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Widget body,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0a0a14).withOpacity(0.5),
            Color(0xFF16213e).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.3),
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
                    colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00F0FF).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.black, size: 20),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: const [Color(0xFF00F0FF), Color(0xFF00FF41)],
                ).createShader(bounds),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          body,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF00FF41), size: 16),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRespuestasSection() {
    return _buildInfoCard(
      title: "Respuestas del Examen",
      icon: Icons.assignment_rounded,
      body: exacontroller.getexamen.id_juego == 2
          ? ListPregunta_Respuesta(
              respuestas: widget.resultado.resultados
                  .map(
                    (resp) => Respuestas_Heroes(
                      id_pregunta: resp['Id_Pregunta'],
                      respuesta: resp['Respuesta'],
                    ),
                  )
                  .toList(),
              heroes: listher,
            )
          : ListPalabra_Respuesta(
              respuestas: widget.resultado.resultados
                  .map(
                    (resp) => Respuestas_Ahorcado(
                      id_palabra: resp['Id_Palabra'],
                      intentos: resp['Intentos'],
                      fallos: resp['Fallos'],
                      aciertos: resp['Aciertos'],
                      acerto: resp['Acerto'],
                    ),
                  )
                  .toList(),
              ahorcado: listahorcado,
            ),
    );
  }

  Widget _buildNotaCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0a0a14).withOpacity(0.5),
            Color(0xFF16213e).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF00FF41).withOpacity(0.3),
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
                    colors: const [Color(0xFF00FF41), Color(0xFF00F0FF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00FF41).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(Icons.grade_rounded, color: Colors.black, size: 20),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: const [Color(0xFF00FF41), Color(0xFF00F0FF)],
                ).createShader(bounds),
                child: Text(
                  "Calificación",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              _buildEditButton(),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: notaController,
            enabled: editar,
            style: TextStyle(color: Colors.white),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              labelText: 'Nota actual: ${widget.resultado.nota} / 5.0',
              labelStyle: TextStyle(color: Colors.grey[400]),
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese una nota';
              }
              final num? nota = num.tryParse(value);
              if (nota == null) return 'Número inválido';
              if (nota < 0 || nota > 5) {
                return 'La nota debe estar entre 0 y 5';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecomendacionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0a0a14).withOpacity(0.5),
            Color(0xFF16213e).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.3),
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
                child: Icon(
                  Icons.comment_rounded,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                ).createShader(bounds),
                child: Text(
                  "Recomendación",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: recomendacionController,
            enabled: editar,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  (widget.resultado.recomendacion == null ||
                      widget.resultado.recomendacion!.isEmpty)
                  ? "Escribe tu recomendación para el estudiante..."
                  : widget.resultado.recomendacion,
              hintStyle: TextStyle(color: Colors.grey[600]),
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            minLines: 4,
            maxLines: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          editar = !editar;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: editar
              ? Color(0xFF00FF41).withOpacity(0.2)
              : Color(0xFF00F0FF).withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: editar
                ? Color(0xFF00FF41).withOpacity(0.5)
                : Color(0xFF00F0FF).withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Icon(
          editar ? Icons.edit_off_rounded : Icons.edit_rounded,
          color: editar ? Color(0xFF00FF41) : Color(0xFF00F0FF),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
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
          if (_formKey.currentState!.validate()) {
            setState(() => editar = false);
            var calificar = Calificar(
              id_estu_exa: widget.resultado.id,
              id_estu: widget.resultado.id_Estudiante,
              nota: double.parse(notaController.text),
              reco: recomendacionController.text,
            );
            var res = await exacontroller.calificarExamen(
              calificar,
              user.gettoken,
            );
            if (res) {
              Get.snackbar(
                '✅ Calificado',
                'El examen fue calificado exitosamente',
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
              Get.to(() => ExamenView(vista: "Examen"));
            } else {
              Get.snackbar(
                '❌ Error',
                'Hubo un problema al calificar el examen',
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
          }
        },
        icon: Icon(Icons.save_rounded, color: Colors.black, size: 24),
        label: Text(
          'Guardar Calificación',
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
