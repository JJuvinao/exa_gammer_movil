import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/game/ahorcado/ahorcado_controller.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/game/ahorcado/mensaje.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AhorcadoPage extends StatefulWidget {
  Ahorcado ahorcado = Ahorcado(palabra: "", pista: "");
  int id_user = 0;
  String token = "";
  int id_examen = 0;

  AhorcadoPage({
    super.key,
    required this.ahorcado,
    required this.id_user,
    required this.token,
    required this.id_examen,
  });

  @override
  State<AhorcadoPage> createState() => _AhorcadoPageState();
}

class _AhorcadoPageState extends State<AhorcadoPage> {
  late final AhorcadoController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    controller.reiniciarJuego();
    controller.nuevaPalabra(widget.ahorcado);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void MostrarMensaje() {
    final resultados = controller.getResultados();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Mensaje(resultados: resultados);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Juego del Ahorcado"),
        backgroundColor: Colors.blueGrey,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Pista: ${controller.pistaActual}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  controller.renderizarPalabra(),
                  style: const TextStyle(
                    fontSize: 40,
                    letterSpacing: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Intentos restantes: ${controller.intentos}",
                  style: const TextStyle(fontSize: 20, color: Colors.redAccent),
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 6,
                  runSpacing: 6,
                  children: "abcdefghijklmnopqrstuvwxyz".split("").map((letra) {
                    final usada = controller.letrasUsadas.contains(letra);
                    return ElevatedButton(
                      onPressed: usada || !controller.juegoActivo
                          ? null
                          : () => {
                              setState(() => controller.manejarLetra(letra)),
                              if (!controller.juegoActivo)
                                {
                                  controller.saveResultado(
                                    widget.id_user,
                                    widget.token,
                                    widget.id_examen,
                                  ),
                                  MostrarMensaje(),
                                },
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        backgroundColor: usada
                            ? Colors.grey[400]
                            : Colors.blueAccent,
                      ),
                      child: Text(
                        letra.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
