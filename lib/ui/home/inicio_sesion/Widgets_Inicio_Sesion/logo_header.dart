import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00F0FF).withOpacity(0.3),
                  const Color(0xFF00FF41).withOpacity(0.3),
                ],
              ),
              border: Border.all(color: const Color(0xFF00F0FF), width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00F0FF).withOpacity(0.6),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset('assets/imagen/logo_exa.png', height: 80),
          ),
          const SizedBox(height: 24),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41), Color(0xFF00F0FF)],
            ).createShader(bounds),
            child: const Text(
              'EXA-GAMMER',
              style: TextStyle(
                fontFamily: "TitanOne",
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
            child: const Text(
              'Tu plataforma educativa gamificada',
              style: TextStyle(
                fontFamily: "poppins",
                fontSize: 14,
                color: Color(0xFF00F0FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}