import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';

class ExamenCard extends StatefulWidget {
  final dynamic actividad;

  const ExamenCard({super.key, required this.actividad});

  @override
  State<ExamenCard> createState() => _ExamenCardState();
}

class _ExamenCardState extends State<ExamenCard> {
  final examenController = Get.put(ExamenController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00F0FF).withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => {
            examenController.saveExamen(widget.actividad),
            Get.to(() => ExamenView(vista: "Examen")),
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 16),
                _divider(),
                const SizedBox(height: 16),
                _infoRow(Icons.topic_rounded, 'Tema', widget.actividad.tema),
                const SizedBox(height: 12),
                _infoRow(
                  Icons.description_rounded,
                  'Descripción',
                  widget.actividad.descripcion,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00F0FF).withOpacity(0.5),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(Icons.quiz_rounded, color: Colors.black, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            widget.actividad.nombre,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF00F0FF),
              shadows: [Shadow(color: Color(0xFF00F0FF), blurRadius: 8)],
            ),
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xFF00FF41),
          size: 20,
        ),
      ],
    );
  }

  Widget _divider() => Container(
    height: 1,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.transparent, Color(0xFF00F0FF), Colors.transparent],
      ),
    ),
  );

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF00FF41).withOpacity(0.7), size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
