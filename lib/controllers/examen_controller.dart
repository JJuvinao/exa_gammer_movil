import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamenController extends GetxController {
  final type = "Content-Type";
  final app = "application/json";
  var examenList = <Examen>[].obs;
  var resultadosList = <Resultados>[].obs;
  var userResult = <Userto>[].obs;
  var heroesList = <Heroes>[].obs;
  var ahorcadoList = <Ahorcado>[].obs;
  dynamic resultados = [];
  final _storageService = Get.find<StorageService>();

  Examen get getexamen => _storageService.displayExamen;
  Ahorcado get getcontextahorcado => _storageService.displayAhorcado;
  List<Ahorcado> get getcontextahorcadoList => ahorcadoList.toList();
  List<Heroes> get getcontextheroes => heroesList.toList();

  Future<void> saveExamen(Examen examen) async {
    await _storageService.saveExamen(examen);
  }

  Future<void> saveContExaAhorcado(Ahorcado newCont) async {
    await _storageService.saveContExaAhorcado(newCont);
  }

  Future<void> logoutExamen() async {
    await _storageService.logoutExamen();
  }

  void addExamen(Examen actividad) {
    examenList.add(actividad);
  }

  void clearExamen() {
    examenList.clear();
  }

  Future<dynamic> getResultado(int idUser, int idExamen, String token) async {
    await resultadoEstudiante(idUser, idExamen, token);
    return resultados;
  }

  Future<List<Examen>> filteredList(int id, String token) async {
    await cargarExamenes(id, token);
    if (examenList.isEmpty) {
      return [];
    }
    return examenList;
  }

  Future<List<Heroes>> listaHeroes(String codigo, String token) async {
    await cargarHeroes(codigo, token);
    if (heroesList.isEmpty) {
      return [];
    }
    return heroesList;
  }

  Future<List<Ahorcado>> listaAhorcados(String codigo, String token) async {
    await cargarAhorcados(token, codigo);
    if (ahorcadoList.isEmpty) {
      return [];
    }
    return ahorcadoList;
  }

  Future<List<Estudi_Resultados>> listresult(
    int idUser,
    int idExamen,
    String token,
  ) async {
    await resultadosEstu(idExamen, token);
    await estudiantesResult(idExamen, token);
    if (resultadosList.isEmpty || userResult.isEmpty) {
      return [];
    }

    var estuResult = <Estudi_Resultados>[];
    for (int i = 0; i < resultadosList.length; i++) {
      if (resultadosList[i].idEstudiane == userResult[i].id) {
        var estu = Estudi_Resultados(
          id: resultadosList[i].id,
          id_Estudiante: userResult[i].id,
          Nombre: userResult[i].username,
          correo: userResult[i].email,
          img: userResult[i].img!,
          id_Examen: resultadosList[i].idExamen,
          resultados: resultadosList[i].resultados,
          nota: resultadosList[i].nota,
          recomendacion: resultadosList[i].recomendacion,
        );
        estuResult.add(estu);
      }
    }
    return estuResult;
  }

  Future<void> cargarExamenes(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Examenes/ExamenesClase/$id',
      );

      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
      );

      if (res.statusCode != 200) {
        print(res.body);
      }
      final data = jsonDecode(res.body);
      List<Examen> examenListe = [];
      for (var item in data) {
        examenListe.add(Examen.fromjson(item));
      }
      examenList.value = examenListe;
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
      'listaAhorcado': data['datos']['listaAhorcado'],
      'lispreheroe': data['datos']['lispreheroe'],
    };
    var datosExamen = {};
    if (data['tipo'] == 'ahorcado') {
      urls = 'https://www.apiexagammer.somee.com/api/Examenes/Ahorcado';
      datosExamen = {
        'Nombre': examen['Nombre'],
        'Tema': examen['Tema'],
        'Autor': examen['Autor'],
        'Descripcion': examen['Descripcion'],
        'ImagenExamen': examen['ImagenExamen'],
        'Id_Clase': examen['Id_Clase'],
        'Id_Juego': examen['Id_Juego'],
        'Palabras_Ahorcados': datos['listaAhorcado'],
      };
    }
    if (data['tipo'] == 'heroes') {
      urls = 'https://www.apiexagammer.somee.com/api/Examenes/Heroes';
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

      final res = await http
          .post(
            url,
            headers: {'Authorization': 'Bearer $token', type: app},
            body: jsonEncode(datosExamen),
          )
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error al guardar el examen: $e');
    }
    return false;
  }

  Future<void> cargarHeroes(String codigo, String token) async {
    try {
      final url = Uri.parse(
        "https://www.apiexagammer.somee.com/api/Examenes/GetConte_Heroe/$codigo",
      );

      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
      );

      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<Heroes> heroeList = [];
      for (var item in data) {
        heroeList.add(Heroes.fromjson(item));
      }
      heroesList.value = heroeList;
    } catch (e) {
      print("ERROR EN CARGAR HEROES ${e.toString()}");
    }
  }

  Future<void> cargarAhorcados(String token, String codigo) async {
    try {
      final url = Uri.parse(
        "https://www.apiexagammer.somee.com/api/Examenes/GetConte_Ahorcado/$codigo",
      );

      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (res.statusCode != 200) {
        return;
      }
      final data = jsonDecode(res.body);
      List<Ahorcado> ahorcados = [];
      for (var item in data) {
        ahorcados.add(Ahorcado.fromjson(item));
      }
      ahorcadoList.value = ahorcados;
    } catch (e) {
      print("ERROR EN CARGAR AHORCADOS ${e.toString()}");
    }
  }

  Future<void> resultadosEstu(int idExamen, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/UsersResultados/$idExamen',
      );

      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
      );
      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<Resultados> resulList = [];
      for (var item in data) {
        resulList.add(Resultados.fromjson(item));
      }
      resultadosList.value = resulList;
    } catch (e) {
      print(
        'Error al cargar los resultados de los estudiantes: ${e.toString()}',
      );
    }
  }

  Future<void> estudiantesResult(int idExamen, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/Estudiantes_exa/$idExamen',
      );

      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
      );
      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      List<Userto> resulList = [];
      for (var item in data) {
        resulList.add(Userto.fromjson(item));
      }
      userResult.value = resulList;
    } catch (e) {
      print('Error al cargar los estudiantes del examen: ${e.toString()}');
    }
  }

  Future<bool> calificarExamen(Calificar calificar, String token) async {
    try {
      final url = Uri.parse(
        "https://apiexagammer.somee.com/api/Estudi_Examen/Calificar",
      );

      final res = await http.put(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
        body: jsonEncode(calificar.toJson()),
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error al calificar el examen: ${e.toString()}');
    }
    return false;
  }

  Future<Resultados> resultadoEstudiante(
    int idUser,
    int idExamen,
    String token,
  ) async {
    try {
      var datos = {"idEstudiane": idUser, "idExamen": idExamen};
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/get_estu_exa',
      );

      final res = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
        body: jsonEncode(datos),
      );
      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      if (data is List && data.isNotEmpty) {
        return Resultados.fromjson(data[0]);
      } else {
        return Resultados(id: 0, idEstudiane: 0, idExamen: 0, resultados: []);
      }
    } catch (e) {
      print('Error al cargar los resultados del estudiante: ${e.toString()}');
    }
    return Resultados(id: 0, idEstudiane: 0, idExamen: 0, resultados: []);
  }

  Future<bool> deleteExamen(int idExamen, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Examenes/$idExamen',
      );

      final res = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $token', type: app},
      );
      if (res.statusCode != 204 && res.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      print("ERROR AL ELIMINAR EXAMEN ${e.toString()}");
    }
    return false;
  }
}
