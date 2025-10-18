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

  Future<bool> guardarExamen(
    Map<String, dynamic> examen,
    Map<dynamic, dynamic> data,
    String token,
  ) async {
    String urls = '';
    var datos = {
      'palabra': data['datos']['palabra'],
      'pista': data['datos']['pista'],
      'lispreheroe': data['datos']['lispreheroe'],
    };
    var datosExamen = {};
    if (data['tipo'] == 'ahorcado') {
      urls = 'https://apiexagammer.somee.com/api/Examenes/Ahorcado';
      datosExamen = {
        'Nombre': examen['Nombre'],
        'Tema': examen['Tema'],
        'Autor': examen['Autor'],
        'Descripcion': examen['Descripcion'],
        'ImagenExamen': examen['ImagenExamen'],
        'Id_Clase': examen['Id_Clase'],
        'Id_Juego': examen['Id_Juego'],
        'Palabras': datos['palabras'],
        'Pistas': datos['pistas'],
      };
    }
    if (data['tipo'] == 'heroes') {
      urls = 'https://apiexagammer.somee.com/api/Examenes/Heroes';
      datosExamen = {
        'Nombre': examen['Nombre'],
        'Tema': examen['Tema'],
        'Autor': examen['Autor'],
        'Descripcion': examen['Descripcion'],
        'ImagenExamen': examen['ImagenExamen'],
        'Id_Clase': examen['Id_Clase'],
        'Id_Juego': examen['Id_Juego'],
        'Heroes': datos['lispreheroe'],
      };
    }
    try {
      final url = Uri.parse(urls);

      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(datosExamen),
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        print('Error al guardar el examen: ${res.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error al guardar el examen: $e');
    }
    return false;
  }
}
