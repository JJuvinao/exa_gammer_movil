import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class ClaseFormCard extends StatelessWidget {
  final TextEditingController txtNombre;
  final TextEditingController txtTema;
  final TextEditingController txtAutor;

  const ClaseFormCard({
    super.key,
    required this.txtNombre,
    required this.txtTema,
    required this.txtAutor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con icono gamer
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00F0FF).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(Icons.school_rounded, color: Colors.black, size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Información de la clase',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00F0FF),
                  shadows: [
                    Shadow(
                      color: Color(0xFF00F0FF),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Completa los datos para crear una nueva clase',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: txtNombre,
            label: 'Nombre de la clase',
            hint: 'Ej: Matemáticas Avanzadas',
            icon: Icons.school_rounded,
            validator: (v) =>
                v!.isEmpty ? 'Por favor ingresa el nombre de la clase' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: txtTema,
            label: 'Tema',
            hint: 'Ej: Álgebra Lineal',
            icon: Icons.topic_rounded,
            validator: (v) => v!.isEmpty ? 'Por favor ingresa el tema' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: txtAutor,
            label: 'Profesor',
            icon: Icons.person_rounded,
            enabled: false,
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00F0FF).withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      );
}