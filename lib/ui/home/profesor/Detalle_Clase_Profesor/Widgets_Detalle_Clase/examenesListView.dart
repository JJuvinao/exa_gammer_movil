import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Detalle_Clase_Profesor/Widgets_Detalle_Clase/examen_card.dart';

class ExamenesListView extends StatelessWidget {
  final RxList<dynamic> filteredExamenes;
  final ExamenController examenController;

  const ExamenesListView({
    super.key,
    required this.filteredExamenes,
    required this.examenController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (filteredExamenes.isEmpty) {
        return const EmptyState();
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: filteredExamenes.length,
        separatorBuilder: (_, __) =>
            const SizedBox(height: 20), // Aumenté el separador
        itemBuilder: (context, index) {
          final examen = filteredExamenes[index];
          return GestureDetector(
            onTap: () {
              examenController.saveExamen(examen);
              Get.to(() => ExamenView(vista: "Examen"));
            },
            child: Container(
              // QUITÉ la altura fija para que sea dinámica
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
              ), // Margen lateral
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
              child: ExamenCard(actividad: examen),
            ),
          );
        },
      );
    });
  }
}
