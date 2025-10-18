import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/game/ahorcado/ahorcado_controller.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/game/ahorcado/mensaje.dart';
import 'package:flutter/services.dart';

class AhorcadoPage extends StatefulWidget {
  const AhorcadoPage({super.key});

  @override
  State<AhorcadoPage> createState() => _AhorcadoPageState();
}

class _AhorcadoPageState extends State<AhorcadoPage> {
  final AhorcadoController controller = Get.find<AhorcadoController>();

  @override
  void initState() {
    super.initState();
    controller.nuevaPalabra();
    // Bloquea en horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Restaurar orientación por defecto al salir
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
                              if (!controller.juegoActivo) {MostrarMensaje()},
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
