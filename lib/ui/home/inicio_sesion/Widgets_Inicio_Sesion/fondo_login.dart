import 'package:flutter/material.dart';

class FondoLogin extends StatelessWidget {
  const FondoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          top: -50,
          right: -50,
          child: _buildCircle(200, const Color(0xFF00F0FF), 0.2),
        ),
        Positioned(
          bottom: -80,
          left: -80,
          child: _buildCircle(250, const Color(0xFF00FF41), 0.15),
        ),
      ],
    );
  }

  Widget _buildCircle(double size, Color color, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(opacity), Colors.transparent],
        ),
      ),
    );
  }
}