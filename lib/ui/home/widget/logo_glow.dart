import 'package:flutter/material.dart';

class LogoGlow extends StatelessWidget {
  final double size;
  final double padding;

  const LogoGlow({
    required this.size,
    this.padding = 20,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
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
            blurRadius: size * 0.25,
            spreadRadius: size * 0.05,
          ),
          BoxShadow(
            color: const Color(0xFF00FF41).withOpacity(0.4),
            blurRadius: size * 0.33,
            spreadRadius: size * 0.025,
          ),
        ],
      ),
      child: Image.asset(
        'assets/imagen/logo_exa.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}