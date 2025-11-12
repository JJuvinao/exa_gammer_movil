import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:flutter/material.dart';

class ListaHeroesView extends StatelessWidget {
  final List<Heroes> heroesList;

  const ListaHeroesView({super.key, required this.heroesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: heroesList.length,
      itemBuilder: (context, index) {
        final hero = heroesList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text('Pregunta ${index + 1}: ${hero.pregunta}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Respuesta correcta: ${hero.respuesta}'),
                const SizedBox(height: 8),
                Text('Opción A: ${hero.respuestaf1}'),
                Text('Opción B: ${hero.respuestaf2}'),
                Text('Opción C: ${hero.respuestaf3}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
