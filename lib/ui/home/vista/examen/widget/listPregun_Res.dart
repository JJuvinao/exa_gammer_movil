import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:flutter/material.dart';

class ListPregunta_Respuesta extends StatefulWidget {
  final List<Respuestas_Heroes> respuestas;
  final List<Heroes> heroes;

  const ListPregunta_Respuesta({
    super.key,
    required this.respuestas,
    required this.heroes,
  });

  @override
  State<ListPregunta_Respuesta> createState() => _ListPregunta_RespuestaState();
}

class _ListPregunta_RespuestaState extends State<ListPregunta_Respuesta> {
  var listRes_Pregunta = <Preguntas_Respuestas>[];

  @override
  void initState() {
    super.initState();
    cargarRespuestas();
  }

  void cargarRespuestas() {
    for (var resp in widget.respuestas) {
      for (var heroe in widget.heroes) {
        if (resp.id_pregunta == heroe.id) {
          listRes_Pregunta.add(
            Preguntas_Respuestas(
              pregunta: heroe.pregunta,
              respuestaV: heroe.respuesta,
              respuesta: resp.respuesta,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return listRes_Pregunta.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: listRes_Pregunta.length,
            itemBuilder: (context, index) {
              final resp = listRes_Pregunta[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text('Pregunta: ${resp.pregunta}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Respuesta correcta: ${resp.respuestaV}'),
                      const SizedBox(height: 8),
                      Text('Respuesta del estudiante: ${resp.respuesta}'),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
