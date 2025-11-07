import 'package:flutter/material.dart';

class AttackMenu extends StatelessWidget {
  final VoidCallback onBasicAttack;
  final VoidCallback onSkill1;
  final VoidCallback onSkill2;
  final VoidCallback onCancel;

  const AttackMenu({
    Key? key,
    required this.onBasicAttack,
    required this.onSkill1,
    required this.onSkill2,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          double boxWidth = screenWidth * 0.8;
          double boxHeight = screenHeight * 0.6;

          boxWidth = boxWidth.clamp(300, 600);
          boxHeight = boxHeight.clamp(300, 500);

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/fondo/cieloazul.jpg",
                  fit: BoxFit.cover,
                ),
              ),

              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.7)),
              ),

              Center(
                child: Container(
                  width: boxWidth,
                  height: boxHeight,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Ataques",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3,
                          children: [
                            attackButton("Ataque Básico", onBasicAttack),
                            attackButton("Habilidad 1", onSkill1),
                            attackButton("Habilidad 2", onSkill2),
                            attackButton("Cancelar", onCancel),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget attackButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade600,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(12),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
