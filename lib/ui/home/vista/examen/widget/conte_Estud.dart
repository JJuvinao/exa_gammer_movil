import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listPalab_Res.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listPregun_Res.dart';
import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:get/get.dart';

class ConteEstu extends StatefulWidget {
  final User user;
  final String token;
  final Examen examen;
  final List<Heroes> listher; // Lista de héroes
  final List<Ahorcado> listaAhorcado; // Lista de palabras del ahorcado

  const ConteEstu({
    super.key,
    required this.user,
    required this.token,
    required this.examen,
    required this.listher,
    required this.listaAhorcado,
  });

  @override
  State<ConteEstu> createState() => _ConteEstuState();
}

class _ConteEstuState extends State<ConteEstu> {
  late final ExamenController exacontroller;
  Resultados resultados = Resultados(
    id: 0,
    id_Estudiane: 0,
    id_Examen: 0,
    resultados: [],
  );
  @override
  void initState() {
    super.initState();
    exacontroller = Get.find<ExamenController>();
    cargarContenido();
  }

  void cargarContenido() async {
    try {
      final r = await exacontroller.ResultadoEstudiante(
        widget.user.id,
        widget.examen.id,
        widget.token,
      );
      setState(() {
        resultados = Resultados(
          id: r.id,
          id_Estudiane: r.id_Estudiane,
          id_Examen: r.id_Examen,
          resultados: r.resultados,
        );
      });

      print("resultados cargado: ${resultados.toJson()}");
    } catch (e) {
      print("Error cargando resultados: $e");
      setState(() => {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),

        const Text(
          "Resultados del Examen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 16),
        // ===== CARD NOTA =====
        Card(
          color: Colors.blue.shade50,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Nota:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  resultados.nota?.toString() ?? "Sin nota",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),

        // ===== CARD RECOMENDACIÓN =====
        Card(
          color: Colors.green.shade50,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Recomendación:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  (resultados.recomendacion?.isNotEmpty ?? false)
                      ? resultados.recomendacion!
                      : "No hay recomendación.",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // ==== CONTENIDO ====
        widget.examen.id_juego != 1
            ? _buildHeroesSection()
            : _buildAhorcadoSection(),
      ],
    );
  }

  // ================================
  Widget _buildHeroesSection() {
    return widget.listher.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : ListPregunta_Respuesta(
            respuestas: resultados.resultados
                .map(
                  (resp) => Respuestas_Heroes(
                    id_pregunta: resp['Id_Pregunta'],
                    respuesta: resp['Respuesta'],
                  ),
                )
                .toList(),
            heroes: widget.listher,
          );
  }

  // ================================
  Widget _buildAhorcadoSection() {
    return widget.listaAhorcado.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : ListPalabra_Respuesta(
            respuestas: resultados.resultados
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
            ahorcado: widget.listaAhorcado,
          );
  }
}
