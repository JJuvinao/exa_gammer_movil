import 'package:exa_gammer_movil/controllers/detalle_clase_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Detalle_Clase_Profesor/Widgets_Detalle_Clase/empty_examenes_widget.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Detalle_Clase_Profesor/Widgets_Detalle_Clase/examen_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/add_examen.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetalleClase extends StatefulWidget {
  DetalleClase({super.key});

  @override
  State<DetalleClase> createState() => _DetalleClaseState();
}

class _DetalleClaseState extends State<DetalleClase> {
  final controller = Get.put(DetalleClaseController());

  @override
  Widget build(BuildContext context) {
    final clasek = controller.claseController.getclase;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a2e),
        elevation: 0,
        leading: _buildBackButton(context),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(clasek.nombre),
                const SizedBox(height: 24),
                _buildSectionTitle(),
                const SizedBox(height: 16),
                Expanded(child: _buildExamenList()),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00F0FF).withOpacity(0.2),
              Color(0xFF00FF41).withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF00F0FF).withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF00F0FF),
          size: 20,
        ),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildHeader(String nombre) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a1a2e).withOpacity(0.8),
            Color(0xFF16213e).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Image.asset('assets/imagen/logo_exa.png', height: 50),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
              ).createShader(bounds),
              child: AutoSizeText(
                nombre.toUpperCase(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "TitanOne",
                  color: Colors.white,
                ),
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00F0FF), Color(0xFF00FF41)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Actividades',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00F0FF),
          ),
        ),
        const SizedBox(width: 8),
        Obx(
          () => Text(
            '(${controller.examenesList.length})',
            style: const TextStyle(
              color: Color(0xFF00FF41),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExamenList() {
    return Obx(() {
      final list = controller.examenesList;
      if (list.isEmpty) return const EmptyExamenesWidget();

      return ListView.separated(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: list.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (_, i) => ExamenCard(actividad: list[i]),
      );
    });
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () => {Get.to(() => AddExamen())},
      backgroundColor: const Color(0xFF00F0FF),
      child: const Icon(Icons.add, color: Colors.black),
    );
  }
}
