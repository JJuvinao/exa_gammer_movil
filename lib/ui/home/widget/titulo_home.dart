import 'package:flutter/material.dart';

class TituloHome extends StatelessWidget {
  const TituloHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41), Color(0xFF00F0FF)],
            ).createShader(bounds),
            child: Text(
              'EXA-GAMMER',
              maxLines: 1,
              style: TextStyle(
                fontSize: screenWidth * 0.14,
                color: Colors.white,
                fontFamily: 'TitanOne',
                letterSpacing: 2,
                shadows: const [
                  Shadow(color: Color(0xFF00F0FF), blurRadius: 30),
                  Shadow(color: Color(0xFF00FF41), blurRadius: 40),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.01,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00F0FF).withOpacity(0.2),
                const Color(0xFF00FF41).withOpacity(0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00F0FF).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            'Aprende jugando',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: const Color(0xFF00F0FF),
              fontWeight: FontWeight.w600,
              fontFamily: "poppins",
            ),
          ),
        ),
      ],
    );
  }
}