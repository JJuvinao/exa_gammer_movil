import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/ui/course/widget/modulesTab.dart';
import 'package:exa_gammer_movil/ui/course/widget/questionsTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Coursecontentview extends StatelessWidget {
  Coursecontentview({super.key});

  final CursoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final curso = controller.selectedCurso!.value;

    return Scaffold(
      appBar: AppBar(title: Text(curso.title)),
      body: DefaultTabController(
        length: 2,
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
              child: TabBarView(children: [ModulesTab(), QuestionsTab()]),
            ),
          ],
        ),
      ),
    );
  }
}
