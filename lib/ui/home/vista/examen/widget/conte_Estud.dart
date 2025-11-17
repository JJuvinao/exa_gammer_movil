import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listPalab_Res.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listPregun_Res.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/validarresultados.dart';
import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';

class ConteEstu extends StatefulWidget {
  final User user;
  final String token;
  final Examen examen;
  final List<Heroes> listher;
  final List<Ahorcado> listaAhorcado;
  final Resultados resultados;

  const ConteEstu({
    super.key,
    required this.user,
    required this.token,
    required this.examen,
    required this.listher,
    required this.listaAhorcado,
    required this.resultados,
  });

  @override
  State<ConteEstu> createState() => _ConteEstuState();
}

class _ConteEstuState extends State<ConteEstu> {
  late Future<bool> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _loadData();
  }

  Future<bool> _loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
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
                  widget.resultados.nota?.toString() ?? "Sin nota",
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
                  (widget.resultados.recomendacion?.isNotEmpty ?? false)
                      ? widget.resultados.recomendacion!
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
    return ContentValidator(
      future: _loadingFuture,
      data: widget.resultados.resultados,
      builder: () {
        return ListPregunta_Respuesta(
          respuestas: widget.resultados.resultados
              .map(
                (resp) => Respuestas_Heroes(
                  id_pregunta: resp['Id_Pregunta'],
                  respuesta: resp['Respuesta'],
                ),
              )
              .toList(),
          heroes: widget.listher,
        );
      },
    );
  }

  // ================================
  Widget _buildAhorcadoSection() {
    return ContentValidator(
      future: _loadingFuture,
      data: widget.resultados.resultados,
      builder: () {
        return ListPalabra_Respuesta(
          respuestas: widget.resultados.resultados
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
      },
    );
  }
}
