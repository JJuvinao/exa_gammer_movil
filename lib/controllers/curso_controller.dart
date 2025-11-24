// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/CursoModel/curso_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CursoController extends GetxController {
  var cursoList = <Curso>[].obs;
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
          .get(url, headers: {'Content-Type': 'application/json'})
          .timeout(Duration(seconds: 15));

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
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Id_user': idUser, 'userRequest': userRequest}),
    );

    if (response.statusCode == 200) {
      isLoading.value = false;
      return response.body;
    }
    throw Exception('Error al generar curso');
  }
}
