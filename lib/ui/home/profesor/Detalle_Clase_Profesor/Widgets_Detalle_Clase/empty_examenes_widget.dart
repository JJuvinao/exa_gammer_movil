import 'package:flutter/material.dart';

class EmptyExamenesWidget extends StatelessWidget {
  const EmptyExamenesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF00F0FF).withOpacity(0.2), Color(0xFF00FF41).withOpacity(0.2)],
              ),
              border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.5), width: 2),
            ),
            child: const Icon(Icons.quiz_outlined, size: 60, color: Color(0xFF00F0FF)),
          ),
          const SizedBox(height: 20),
          const Text('No hay actividades registradas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00F0FF))),
          const SizedBox(height: 8),
          Text('Crea tu primera actividad para comenzar', style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }
}