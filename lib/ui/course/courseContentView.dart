import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:exa_gammer_movil/ui/course/widget/modulesTab.dart';
import 'package:exa_gammer_movil/ui/course/widget/questionTab.dart';
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
                  ModulesTab(curso: curso),
                  QuestionsTab(curso: curso),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
