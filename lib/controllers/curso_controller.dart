// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:exa_gammer_movil/models/CursoModel/modulo_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CursoController extends GetxController {
  final type = "Content-Type";
  final app = "application/json";
  var cursoList = <Curso>[].obs;
  Rx<Curso>? selectedCurso;
  UserController user = Get.find<UserController>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCursos();
  }

  Future<void> fetchCursos() async {
    final int idUser = user.getuser.id;
    isLoading.value = true;
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Cursos/$idUser',
      );

      final res = await http
          .get(url, headers: {type: app})
          .timeout(const Duration(seconds: 15));

      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<Curso> cursoListe = [];
      for (var item in data) {
        cursoListe.add(Curso.fromJson(item));
      }
      cursoList.value = cursoListe;
      isLoading.value = false;
    } catch (e) {
      print("ERROR DE LA CARGA DE CURSOS ${e.toString()}");
    }
  }

  Future<String> generateCurso(String userRequest) async {
    final int idUser = user.getuser.id;
    isLoading.value = true;
    print(userRequest);
    final url = Uri.parse(
      'https://www.apiexagammer.somee.com/api/Cursos/AIGenerate',
    );
    final response = await http.post(
      url,
      headers: {type: app},
      body: jsonEncode({'Id_user': idUser, 'userRequest': userRequest}),
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      return response.body;
    }
    throw Exception('Error al generar curso');
  }

  void CourseSelect(Curso curso) {
    selectedCurso = curso.obs;
  }

  void CompleteModule(ModuloModel module) {
    module.Completed = module.lessons.every(
      (lesson) => lesson.Completed == true,
    );
    update(["Modules"]);
    UpdatePercentage();
  }

  void CompleteCourse() {
    final Curso curso = selectedCurso!.value;
    final bool isModulesCompleted = curso.modules.every(
      (module) => module.Completed == true,
    );
    final bool isQuestionsCompleted = curso.questions.every(
      (question) => question.Completed == true,
    );

    if (isModulesCompleted && isQuestionsCompleted) {
      curso.Completed = true;
    }

    UpdatePercentage();
  }

  void UpdatePercentage() {
    final completedParts =
        selectedCurso!.value.modules.where((m) => m.Completed).length +
        selectedCurso!.value.questions.where((q) => q.Completed).length;

    final totalParts =
        selectedCurso!.value.modules.length +
        selectedCurso!.value.questions.length;

    print(completedParts);
    print(selectedCurso!.value.Num_sections);

    final double percentage = (completedParts / totalParts) * 100;
    selectedCurso!.value.Percentage = percentage.toInt();
    cursoList.refresh();
  }
}
