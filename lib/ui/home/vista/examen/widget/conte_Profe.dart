import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listAhorcados.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listHeroes.dart';
import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';

class ConteProfe extends StatelessWidget {
  final Examen examen;
  final List<Heroes> listher; // Lista de héroes
  final List<Ahorcado> listaAhorcado; // Lista de palabras del ahorcado

  const ConteProfe({
    super.key,
    required this.examen,
    required this.listher,
    required this.listaAhorcado,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),

        const Text(
          "Contenido del Examen",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 16),

        // ==== CONTENIDO ====
        examen.id_juego != 1 ? _buildHeroesSection() : _buildAhorcadoSection(),
      ],
    );
  }

  // ================================
  // SECCIÓN HÉROES
  // ================================
  Widget _buildHeroesSection() {
    return listher.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : ListaHeroesView(heroesList: listher);
  }

  // ================================
  // SECCIÓN AHORCADO
  // ================================
  Widget _buildAhorcadoSection() {
    return listaAhorcado.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          )
        : ListaAhorcadosView(ahorcadoList: listaAhorcado);
  }
}
