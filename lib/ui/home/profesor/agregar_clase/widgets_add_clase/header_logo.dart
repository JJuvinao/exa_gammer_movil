import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo container con efecto neón
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00F0FF).withOpacity(0.2),
                  Color(0xFF00FF41).withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xFF00F0FF),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Color(0xFF00FF41).withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Image.asset(
              'assets/imagen/logo_exa.png',
              height: 45,
            ),
          ),
          const SizedBox(width: 16),
          // Texto con efecto glow
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Color(0xFF00F0FF),
                Color(0xFF00FF41),
              ],
            ).createShader(bounds),
            child: const Text(
              'EXA-GAMMER',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: "TitanOne",
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Color(0xFF00F0FF),
                    blurRadius: 10,
                  ),
                  Shadow(
                    color: Color(0xFF00FF41),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}