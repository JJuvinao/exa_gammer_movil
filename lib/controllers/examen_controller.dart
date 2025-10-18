import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamenController extends GetxController {
  var ExamenList = <Examen>[].obs;
  final _storageService = Get.find<StorageService>();

  Examen get getexamen => _storageService.displayExamen;

  void addExamen(Examen actividad) {
    ExamenList.add(actividad);
  }

  void deleteExamen(int index) {
    ExamenList.removeAt(index);
  }

  void clearExamen() {
    ExamenList.clear();
  }

  List<Examen> filteredList(int id, String token) {
    CargarExamne(id, token);
    if (ExamenList.isEmpty) {
      return [];
    }
    return ExamenList;
  }

  Future<void> CargarExamne(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://apiexagammer.somee.com/api/Examenes/ExamenesClase/${id}',
      );

      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode != 200) {
        print(res.body);
      }
      final data = jsonDecode(res.body);
      List<Examen> _ExamenList = [];
      for (var item in data) {
        _ExamenList.add(Examen.fromjson(item));
      }
      ExamenList.value = _ExamenList;
    } catch (e) {
      print("ERROR DE LA CARGA DE EXAMENES ${e.toString()}");
    }
  }
}
