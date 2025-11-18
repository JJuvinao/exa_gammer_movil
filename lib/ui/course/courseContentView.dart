import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:flutter/material.dart';

class Coursecontentview extends StatelessWidget {
  const Coursecontentview({super.key, required this.curso});

  final Curso curso;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(curso.title)),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: Colors.blue[50],
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    curso.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    curso.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: curso.Percentage / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.menu_book), text: 'Módulos'),
                Tab(icon: Icon(Icons.quiz), text: 'Preguntas'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _ModulesTab(curso: curso),
                  _QuestionsTab(curso: curso),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModulesTab extends StatelessWidget {
  const _ModulesTab({required this.curso});

  final Curso curso;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: curso.modules.length,
      itemBuilder: (context, i) {
        final modulo = curso.modules[i];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: CircleAvatar(child: Text('${i + 1}')),
            title: Text(modulo.title),
            subtitle: Text('${modulo.lessons.length} lecciones'),
            trailing: Icon(
              modulo.Completed
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
            ),
            children: modulo.lessons
                .map(
                  (leccion) => ListTile(
                    leading: Icon(Icons.article),
                    title: Text(leccion.title),
                    subtitle: Text(leccion.content.substring(0, 50) + '...'),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _QuestionsTab extends StatelessWidget {
  const _QuestionsTab({required this.curso});

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
                  int idx = entry.key;
                  String option = entry.value;
                  return RadioListTile<int>(title: Text(option), value: idx, groupValue: null, onChanged: (int? value) {  },);
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
