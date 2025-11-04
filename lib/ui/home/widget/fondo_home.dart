import 'package:flutter/material.dart';

class FondoHome extends StatelessWidget {
  const FondoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: _buildCircle(screenWidth * 0.75, const Color(0xFF00F0FF), 0.2),
          ),
          Positioned(
            bottom: -screenHeight * 0.15,
            left: -screenWidth * 0.3,
            child: _buildCircle(screenWidth, const Color(0xFF00FF41), 0.15),
          ),
        ],
      ),
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