import 'package:flutter/material.dart';

class LifeBar extends StatelessWidget {
  final double currentHp;
  final double maxHp;
  final double width;
  final double height;

  const LifeBar({
    super.key,
    required this.currentHp,
    required this.maxHp,
    this.width = 150,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    double hpPercent = (currentHp / maxHp).clamp(0, 1);

    Color barColor;
    if (hpPercent > 0.6) {
      barColor = Colors.green;
    } else if (hpPercent > 0.3) {
      barColor = Colors.yellow;
    } else {
      barColor = Colors.red;
    }

    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        Container(
          width: width * hpPercent,
          height: height,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              "${currentHp.toInt()}/${maxHp.toInt()}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
