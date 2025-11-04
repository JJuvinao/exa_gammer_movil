import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

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
                colors: [
                  Color(0xFF00F0FF).withOpacity(0.2),
                  Color(0xFF00FF41).withOpacity(0.2),
                ],
              ),
              border: Border.all(
                color: Color(0xFF00F0FF).withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.school_outlined,
              size: 60,
              color: Color(0xFF00F0FF),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No hay clases registradas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00F0FF),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea tu primera clase para comenzar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
