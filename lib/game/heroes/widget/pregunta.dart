import 'package:exa_gammer_movil/game/heroes/controller/heroe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreguntaDialog extends StatefulWidget {
  final String questionText;

  const PreguntaDialog({Key? key, required this.questionText})
    : super(key: key);

  @override
  State<PreguntaDialog> createState() => _PreguntaDialogState();
}

class _PreguntaDialogState extends State<PreguntaDialog> {
  final String backgroundImage = "assets/fondo/cieloazul.jpg";
  final options = ["if", "while", "for", "switch"];
  final HeroeController controller = Get.find<HeroeController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;

        double boxWidth = screenWidth * 0.85;
        double boxHeight = screenHeight * 0.55;

        boxWidth = boxWidth.clamp(400, 700);
        boxHeight = boxHeight.clamp(320, 550);

        double buttonTextSize = screenWidth < 500 ? 12 : 16;
        double questionTextSize = screenWidth < 400 ? 14 : 18;

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(backgroundImage, fit: BoxFit.cover),
            ),

            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

            Center(
              child: Container(
                width: boxWidth,
                height: boxHeight,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue, width: 3),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Pregunta y respuesta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Flexible(
                      child: Text(
                        widget.questionText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: questionTextSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Expanded(
                      flex: 2,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 6,
                        children: options.map((option) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => {
                              controller.saveRespuesta(option),
                              Get.back(),
                            },
                            child: Text(
                              '"$option"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: buttonTextSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
