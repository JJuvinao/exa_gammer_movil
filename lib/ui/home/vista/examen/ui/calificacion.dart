import 'package:auto_size_text/auto_size_text.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
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
      backgroundColor: const Color(0xFF0a0a14), // Fondo oscuro
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e), // Color oscuro para la AppBar
        elevation: 0,
        iconTheme: IconThemeData(color: const Color(0xFF00F0FF)),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
          ).createShader(bounds),
          child: const Text(
            "Calificar Examen",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/imagen/logo_exa.png', height: 75),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AutoSizeText(
                            "Calificar examen",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: "TitanOne",
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            minFontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildInfoCard(
                              title: "Estudiante:",
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nombre: ${widget.resultado.Nombre}"),
                                  const SizedBox(height: 8),
                                  Text("Correo: ${widget.resultado.correo}"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            exacontroller.getexamen.id_juego == 2
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
                            const SizedBox(height: 16),
                            _buildInfoCard(
                              title: "Nota:",
                              body: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: notaController,
                                      enabled: editar,
                                      keyboardType: const TextInputType
                                          .numberWithOptions(decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d*\.?\d{0,2}'),
                                        ),
                                      ],
                                      decoration: InputDecoration(
                                        labelText:
                                            '${widget.resultado.nota} / 5.0',
                                        border: OutlineInputBorder(),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Ingrese una nota';
                                        }
                                        final num? nota = num.tryParse(value);
                                        if (nota == null) return 'Número inválido';
                                        if (nota < 0 || nota > 5) {
                                          return 'Entre 0 y 5';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  _buildEditButton(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoCard(
                              title: "Recomendación:",
                              body: TextFormField(
                                controller: recomendacionController,
                                enabled: editar,
                                decoration: InputDecoration(
                                  hintText: (widget.resultado.recomendacion ==
                                          null ||
                                      widget.resultado.recomendacion!
                                          .isEmpty)
                                      ? "Escribe tu recomendación..."
                                      : widget.resultado.recomendacion,
                                  border: OutlineInputBorder(),
                                ),
                                minLines: 4,
                                maxLines: 8,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => editar = false);
                                  var calificar = Calificar(
                                    id_estu_exa: widget.resultado.id,
                                    id_estu: widget.resultado.id_Estudiante,
                                    nota: double.parse(notaController.text),
                                    reco: recomendacionController.text,
                                  );
                                  var res = await exacontroller.CalificarExamen(
                                    calificar,
                                    user.gettoken,
                                  );
                                  Get.back();
                                  if (res) {
                                    Get.snackbar(
                                      'Calificado',
                                      'El examen fue calificado exitosamente.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green[100],
                                      colorText: Colors.black87,
                                    );
                                  } else {
                                    Get.snackbar(
                                      'Error',
                                      'Hubo un problema al calificar el examen',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red[100],
                                      colorText: Colors.black87,
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Guardar'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ), backgroundColor: const Color(0xFF00F0FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


//color de las preguntas....
  Widget _buildInfoCard({required String title, required Widget body}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
            ).createShader(bounds),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333), // Color oscuro
              ),
            ),
          ),
          const SizedBox(height: 12),
          body,
        ],
      ),
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
      child: Icon(
        editar ? Icons.edit_off : Icons.edit,
        color: const Color(0xFF00F0FF),
      ),
    );
  }
}
