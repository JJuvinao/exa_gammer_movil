import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:flutter/material.dart';

class ListaAhorcadosView extends StatelessWidget {
  final List<Ahorcado> ahorcadoList;

  const ListaAhorcadosView({super.key, required this.ahorcadoList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: ahorcadoList.length,
      itemBuilder: (context, index) {
        final ahorca = ahorcadoList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text('Pregunta: ${ahorca.palabra}'),
            subtitle: Text('Pista: ${ahorca.pista}'),
          ),
        );
      },
    );
  }
}
