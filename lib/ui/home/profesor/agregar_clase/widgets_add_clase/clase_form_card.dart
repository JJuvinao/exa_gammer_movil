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

  String? _validarNombre(String? valor) {
    return _validarCampo(valor, 'El nombre');
  }

  String? _validarTema(String? valor) {
    return _validarCampo(valor, 'El tema');
  }

  String? _validarCampo(String? valor, String nombreCampo) {
    if (valor == null || valor.isEmpty) {
      return '$nombreCampo no puede estar vacío';
    }
    if (valor.trim().isEmpty) {
      return '$nombreCampo no puede contener solo espacios';
    }

    if (valor.length < 5) {
      return '$nombreCampo debe tener al menos 5 caracteres';
    }

    if (valor.length > 20) {
      return '$nombreCampo debe tener máximo 20 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                child: Icon(
                  Icons.school_rounded,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Información de la clase',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00F0FF),
                  shadows: [Shadow(color: Color(0xFF00F0FF), blurRadius: 10)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Completa los datos para crear una nueva clase',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),

          const SizedBox(height: 12),
          _buildInfoValidacion(),

          const SizedBox(height: 24),

          CustomTextField(
            key: Key('txtNombreClase'),
            controller: txtNombre,
            label: 'Nombre de la clase',
            hint: 'Ej: Matemáticas Avanzadas (5-20 caracteres)',
            icon: Icons.school_rounded,
            validator: _validarNombre,
          ),

          const SizedBox(height: 16),

          CustomTextField(
            key: Key('txtTemaClase'),
            controller: txtTema,
            label: 'Tema',
            hint: 'Ej: Álgebra Lineal (5-20 caracteres)',
            icon: Icons.topic_rounded,
            validator: _validarTema,
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

  Widget _buildInfoValidacion() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF0a0a14).withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF00FF41).withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFF00FF41), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Nombre y Tema: entre 5 y 20 caracteres',
              style: TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() => BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Color(0xFF00F0FF).withOpacity(0.3), width: 1.5),
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
