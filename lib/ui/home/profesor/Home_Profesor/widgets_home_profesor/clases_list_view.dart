import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:exa_gammer_movil/ui/home/widget/ClaseCard.dart';


class ClasesListView extends StatelessWidget {
  final RxList<dynamic> filteredClase;
  final ClaseController claseController;

  const ClasesListView({
    super.key,
    required this.filteredClase,
    required this.claseController,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (filteredClase.isEmpty) {
        return const EmptyState();
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: filteredClase.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final clase = filteredClase[index];
          return GestureDetector(
            onTap: () {
              claseController.saveClase(clase);
              Get.to(() => ClaseView(vista: "Clase"));
            },
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1a1a2e),
                    Color(0xFF16213e),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Color(0xFF00F0FF).withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF00F0FF).withOpacity(0.2),
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
              child: ObjetoCard(
                titulo: clase.nombre,
                imagenUrl: clase.img,
                onTap: () {
                  claseController.saveClase(clase);
                  Get.to(() => ClaseView(vista: "Clase"));
                },
              ),
            ),
          );
        },
      );
    });
  }
}