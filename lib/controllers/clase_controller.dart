import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ClaseController extends GetxController {
  var claseList = <Clase>[].obs;
  var searchQuery = ''.obs;
  final _storageService = Get.find<StorageService>();

  Clase get getclase => _storageService.displayClase;

  Future<void> saveClase(Clase newClase) async {
    await _storageService.saveClase(newClase);
  }

  Future<void> logoutClase() async {
    await _storageService.logoutClase();
  }

  void ClearClase() {
    claseList.clear();
  }

  Future<bool> AddClase(Clasedto newclase, String token) async {
    final url = Uri.parse(
      'https://www.apiexagammer.somee.com/api/Clases/ClasePost',
    );
    try {
      final res = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(newclase.toJson()),
          )
          .timeout(Duration(seconds: 15));
      if (res.statusCode != 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print("ERROR DEL AGRECAR CLASE");
    }
    return false;
  }

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

  Future<List<Clase>> filteredList(int id, String token, String rol) async {
    if (rol == 'Profesor') {
      await CargarClases(id, token);
    } else {
      await CargarClases_Estudiante(id, token);
    }
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

  Future<void> CargarClases(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Clases/Profe_Clases/${id}',
      );

      final res = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json',
            },
          )
          .timeout(Duration(seconds: 15));

      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<Clase> _claseList = [];
      for (var item in data) {
        _claseList.add(Clase.fromjson(item));
      }
      claseList.value = _claseList;
    } catch (e) {
      print("ERROR DE LA CARGA DE CLASES ${e.toString()}");
    }
  }

  Future<void> CargarClases_Estudiante(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Clases/${id}',
      );

      final res = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json',
            },
          )
          .timeout(Duration(seconds: 15));

      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<Clase> _claseList = [];
      for (var item in data) {
        _claseList.add(Clase.fromjson(item));
      }
      claseList.value = _claseList;
    } catch (e) {
      print("ERROR DE LA CARGA DE CLASES ${e.toString()}");
    }
  }
}
