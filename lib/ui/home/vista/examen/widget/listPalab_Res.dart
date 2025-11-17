import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:flutter/material.dart';

class ListPalabra_Respuesta extends StatefulWidget {
  final List<Respuestas_Ahorcado> respuestas;
  final List<Ahorcado> ahorcado;

  const ListPalabra_Respuesta({
    super.key,
    required this.respuestas,
    required this.ahorcado,
  });

  @override
  State<ListPalabra_Respuesta> createState() => _ListPalabra_RespuestaState();
}

class _ListPalabra_RespuestaState extends State<ListPalabra_Respuesta> {
  var listRes_Pregunta = <Resultado_Ahorcado>[];

  @override
  void initState() {
    super.initState();
    cargarRespuestas();
  }

  void cargarRespuestas() {
    print("Cargando respuestas...");
    print("Respuestas recibidas: ${widget.respuestas.length}");
    print("Ahorcado recibido: ${widget.ahorcado.length}");
    for (var resp in widget.respuestas) {
      for (var ahor in widget.ahorcado) {
        if (resp.id_palabra == ahor.id) {
          listRes_Pregunta.add(
            Resultado_Ahorcado(
              palabra: ahor.palabra,
              pista: ahor.pista,
              intentos: resp.intentos,
              fallos: resp.fallos,
              aciertos: resp.aciertos,
              acerto: resp.acerto,
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
                color: resp.acerto
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text('Palabra: ${resp.palabra}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pista: ${resp.pista}'),
                      const SizedBox(height: 8),
                      Text(
                        'Respuesta del estudiante: ${resp.acerto ? "Correcta" : "Incorrecta"}',
                      ),
                      Text('Intentos: ${resp.intentos}'),
                      Text('Aciertos: ${resp.aciertos}'),
                      Text('Fallos: ${resp.fallos}'),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
