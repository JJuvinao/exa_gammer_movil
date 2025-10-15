import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaseController extends GetxController {
  var claseList = <clase>[].obs;
  var searchQuery = ''.obs;

  void addClase(String nombre, String tema, String autor) {}

  void updateClase(
    int index,
    String newNombre,
    String newTema,
    String newAutor,
  ) {}

  void deleteClase(int index) {
    claseList.removeAt(index);
  }

  // Método para actualizar la búsqueda
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<clase> filteredList(int id, String token) {
    CragarClases(id, token);
    if (claseList.isEmpty) {
      return [];
    }
    if (searchQuery.value.isEmpty) {
      return claseList;
    } else {
      return claseList
          .where(
            (clase) => clase.nombre.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ),
          )
          .toList();
    }
  }

  Future<void> CragarClases(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://apiexagammer.somee.com/api/Clases/Profe_Clases/${id}',
      );

      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<clase> _claseList = [];
      for (var item in data) {
        _claseList.add(clase.fromjson(item));
      }
      claseList.value = _claseList;
    } catch (e) {
      print("ERROR DE LA CARGA DE CLASES ${e.toString()}");
    }
  }
}
