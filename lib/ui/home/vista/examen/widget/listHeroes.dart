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
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            title: Text('Pregunta: ${hero.pregunta}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Respuesta correcta: ${hero.respuesta}'),
                const SizedBox(height: 8),
                Text('Respuesta Incorrecta 1: ${hero.respuestaf1}'),
                Text('Respuesta Incorrecta 2: ${hero.respuestaf2}'),
                Text('Respuesta Incorrecta 3: ${hero.respuestaf3}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
