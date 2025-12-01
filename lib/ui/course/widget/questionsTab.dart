import 'package:exa_gammer_movil/controllers/curso_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/pregunta_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionsTab extends StatefulWidget {
  QuestionsTab({super.key});

  final CursoController controller = Get.find();

  @override
  State<QuestionsTab> createState() => _QuestionsTabState();
}

class _QuestionsTabState extends State<QuestionsTab> {
  Map<int, int> selectedAnswers = {};

  void _CheckAnswer(int? answer, PreguntaModel question) {
    if (question.Completed) {
      return;
    }
    final int answerIndex = question.answerIndex;
    if (answer == null) {
      Get.snackbar(
        "¡Espera!",
        "Debes seleccionar una respuesta antes de enviar",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final bool correct = answer == answerIndex;
    if (correct) {
      question.Completed = true;
      widget.controller.CompleteCourse();
    }

    Get.snackbar(
      correct ? "¡Correcto!" : "Incorrecto",
      correct
          ? "¡Muy bien! Has acertado la pregunta."
          : "La respuesta correcta era: ${question.options[answerIndex]}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: correct ? Colors.green[600] : Colors.red[600],
      colorText: Colors.white,
      duration: Duration(seconds: 4),
      icon: Icon(
        correct ? Icons.celebration : Icons.sentiment_dissatisfied,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final curso = widget.controller.selectedCurso!.value;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: curso.questions.length,
            itemBuilder: (context, i) {
              final pregunta = curso.questions[i];

              return Card(
                elevation: 5,
                shadowColor: Colors.deepPurpleAccent,
                color: const Color.fromARGB(255, 25, 25, 51),
                margin: EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pregunta ${i + 1}: ${pregunta.text}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 173, 173, 173),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 12),
                      ...pregunta.options.asMap().entries.map((entry) {
                        int index = entry.key;
                        String option = entry.value;
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: RadioListTile<int>(
                              title: Text(option),
                              value: index,
                              groupValue: pregunta.Completed
                                  ? pregunta.answerIndex
                                  : selectedAnswers[i],
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswers[i] = value!;
                                });
                              },
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            _CheckAnswer(selectedAnswers[i], pregunta),
                        child: Text("Enviar"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
