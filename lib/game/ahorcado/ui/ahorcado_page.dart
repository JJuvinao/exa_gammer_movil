import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/game/ahorcado/controller/ahorcado_controller.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class AhorcadoPage extends StatefulWidget {
  final List<Ahorcado> ahorcados;
  int id_user = 0;
  String token = "";
  int id_examen = 0;

  AhorcadoPage({
    super.key,
    required this.ahorcados,
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
    controller.cargarPalabras(widget.ahorcados);
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

  void MostrarMensaje() {}

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
                const SizedBox(height: 10),
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
                const SizedBox(height: 5),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 1,
                  runSpacing: 1,
                  children: "abcdefghijklmnopqrstuvwxyz0123456789"
                      .split("")
                      .map((letra) {
                        final usada = controller.letrasUsadas.contains(letra);
                        return buildKeyButton(
                          letra.toUpperCase(),
                          usada,
                          usada || !controller.juegoActivo
                              ? null
                              : () {
                                  setState(
                                    () => controller.manejarLetra(letra),
                                  );

                                  if (!controller.juegoActivo) {
                                    if (!controller.juegoTerminado) {
                                      controller.siguientePalabra();
                                    } else {
                                      controller.saveResultado(
                                        widget.id_user,
                                        widget.token,
                                        widget.id_examen,
                                      );
                                      MostrarMensaje();
                                      Get.off(
                                        () => ExamenView(vista: "Examen"),
                                      );
                                    }
                                  }
                                },
                        );
                      })
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildKeyButton(String text, bool usada, VoidCallback? onPressed) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonWidth = (MediaQuery.of(context).size.width / 13) - 8;

        return SizedBox(
          width: buttonWidth,
          child: ElevatedButton(
            onPressed: usada ? null : onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              backgroundColor: usada ? Colors.grey[400] : Colors.blueAccent,
              minimumSize: Size(buttonWidth, 20),
            ),
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
