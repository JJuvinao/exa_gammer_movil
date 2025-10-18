import 'package:flutter/material.dart';

class Mensaje extends StatelessWidget {
  final Map<String, dynamic> resultados;

  const Mensaje({super.key, required this.resultados});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Resultado del Juego"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              resultados['estado'] == "Ganó"
                  ? "🎉 ¡Felicidades, ganaste! 🎉"
                  : "😢 ¡Perdiste! 😢",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "La palabra era: ${resultados['palabra']}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              "Fallos: ${resultados['fallos']}",
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            Text(
              "Aciertos: ${resultados['aciertos']}",
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            Text(
              "Intentos restantes: ${resultados['intentos']}",
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        const SizedBox(width: 10),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Aceptar"),
        ),
      ],
    );
  }
}
