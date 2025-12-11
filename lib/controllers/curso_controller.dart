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
      final url = Uri.parse('https://localhost:7248/api/Cursos/$idUser');

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

  Future<String?> generateCurso(String userRequest) async {
    final int idUser = user.getuser.id;
    isLoading.value = true;
    try {
      final url = Uri.parse('https://localhost:7248/api/Cursos/AIGenerate');
      final response = await http.post(
        url,
        headers: {type: app},
        body: jsonEncode({'Id_user': idUser, 'userRequest': userRequest}),
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        return response.body;
      }
    } catch (e) {
      isLoading.value = false;
      return "ERROR AL GENERAR CURSO ${e.toString()}";
    }
  }

  Future<bool> PutCurso() async {
    if (selectedCurso?.value == null) return false;
    var curso = selectedCurso!.value;

    try {
      final url = Uri.parse('https://localhost:7248/api/Cursos');
      final response = await http.put(
        url,
        headers: {type: app},
        body: jsonEncode(curso.toUpdateJson()),
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }

  Future<void> DeleteCurso(int idCurso) async {
    final int idUser = user.getuser.id;
    try {
      final url = Uri.parse('https://localhost:7248/api/Cursos');
      final response = await http.delete(
        url,
        headers: {type: app},
        body: jsonEncode({"id_curso": idCurso, "id_user": idUser}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        cursoList.removeWhere((c) => c.id_curso == idCurso);
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo eliminar el curso");
    }
  }

  void CourseSelect(Curso curso) {
    selectedCurso = curso.obs;
  }

  void CompleteModule(ModuloModel module) {
    module.Completed = module.lessons.every(
      (lesson) => lesson.completed == true,
    );

    update(["Modules"]);
    UpdatePercentage();
  }

  bool AreModulesCompleted() {
    return selectedCurso!.value.modules.every((m) => m.Completed == true);
  }

  void CompleteCourse() {
    final Curso curso = selectedCurso!.value;

    final bool isQuestionsCompleted = curso.questions.every(
      (question) => question.Completed == true,
    );

    if (isQuestionsCompleted) {
      curso.completed = true;
    }

    UpdatePercentage();
  }

  void UpdatePercentage() {
    selectedCurso!.value.completed_sections += 1;
    final double percentage =
        (selectedCurso!.value.completed_sections /
            selectedCurso!.value.num_sections) *
        100;
    selectedCurso!.value.percentage = percentage.toInt();
    selectedCurso!.refresh();
  }

  Future<void> RefreshAndSave() async {
    if (selectedCurso!.value.completed) {
      return;
    }
    cursoList.refresh();
    await PutCurso();
  }
}
