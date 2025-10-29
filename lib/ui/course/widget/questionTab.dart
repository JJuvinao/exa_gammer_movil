import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:flutter/material.dart';

class QuestionsTab extends StatelessWidget {
  const QuestionsTab({required this.curso});

  final Curso curso;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: curso.questions.length,
      itemBuilder: (context, i) {
        final pregunta = curso.questions[i];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pregunta ${i + 1}: ${pregunta.text}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                ...pregunta.options.asMap().entries.map((entry) {
                  int index = entry.key;
                  String option = entry.value;
                  return RadioListTile<int>(title: Text(option), value: index);
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
