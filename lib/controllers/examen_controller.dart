import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamenController extends GetxController {
  var examenList = <Examen>[].obs;
  var resultadosList = <Resultados>[].obs;
  var userResult = <Userto>[].obs;
  var heroesList = <Heroes>[].obs;
  var ahorcadoList = <Ahorcado>[].obs;
  var resultados;
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

  void deleteExamen(int index) {
    examenList.removeAt(index);
  }

  void clearExamen() {
    examenList.clear();
  }

  Future<dynamic> getResultado(int id_user, int id_examen, String token) async {
    await ResultadoEstudiante(id_user, id_examen, token);
    return resultados;
  }

  Future<List<Examen>> filteredList(int id, String token) async {
    await CargarExamenes(id, token);
    if (examenList.isEmpty) {
      return [];
    }
    return examenList;
  }

  Future<List<Heroes>> listaHeroes(String codigo, String token) async {
    await CargarHeroes(codigo, token);
    if (heroesList.isEmpty) {
      return [];
    }
    return heroesList;
  }

  Future<List<Ahorcado>> listaAhorcados(String codigo, String token) async {
    await CargarAhorcados(token, codigo);
    if (ahorcadoList.isEmpty) {
      return [];
    }
    return ahorcadoList;
  }

  Future<List<Estudi_Resultados>> listresult(
    int id_user,
    int id_examen,
    String token,
  ) async {
    await Resultados_Estu(id_examen, token);
    await Estudiantes_Result(id_examen, token);
    if (resultadosList.isEmpty || userResult.isEmpty) {
      return [];
    }

    var estu_Result = <Estudi_Resultados>[];
    for (int i = 0; i < resultadosList.length; i++) {
      if (resultadosList[i].id_Estudiane == userResult[i].id) {
        var estu = Estudi_Resultados(
          id: resultadosList[i].id,
          id_Estudiante: userResult[i].id,
          Nombre: userResult[i].username,
          correo: userResult[i].email,
          img: userResult[i].img!,
          id_Examen: resultadosList[i].id_Examen,
          resultados: resultadosList[i].resultados,
          nota: resultadosList[i].nota,
          recomendacion: resultadosList[i].recomendacion,
        );
        estu_Result.add(estu);
      }
      ;
    }
    return estu_Result;
  }

  Future<void> CargarExamenes(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Examenes/ExamenesClase/${id}',
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
      examenList.value = _ExamenList;
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
    print("los datos del examen son: $datosExamen");
    try {
      final url = Uri.parse(urls);

      final res = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer ${token}',
              'Content-Type': 'application/json',
            },
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

  Future<void> CargarHeroes(String codigo, String token) async {
    try {
      final url = Uri.parse(
        "https://www.apiexagammer.somee.com/api/Examenes/GetConte_Heroe/${codigo}",
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
        print(res.body);
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

  Future<void> CargarAhorcados(String token, String codigo) async {
    try {
      final url = Uri.parse(
        "https://www.apiexagammer.somee.com/api/Examenes/GetConte_Ahorcado/${codigo}",
      );

      final res = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${token}'},
      );

      if (res.statusCode != 200) {
        print(res.statusCode);
        print(res.body);
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

  Future<void> Resultados_Estu(int id_examen, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/UsersResultados/${id_examen}',
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

  Future<void> Estudiantes_Result(int id_examen, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/Estudiantes_exa/${id_examen}',
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
      List<Userto> resulList = [];
      for (var item in data) {
        resulList.add(Userto.fromjson(item));
      }
      userResult.value = resulList;
    } catch (e) {
      print('Error al cargar los estudiantes del examen: ${e.toString()}');
    }
  }

  Future<bool> CalificarExamen(Calificar calificar, String token) async {
    try {
      final url = Uri.parse(
        "https://apiexagammer.somee.com/api/Estudi_Examen/Calificar",
      );

      final res = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(calificar.toJson()),
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        print('Error al guardar el examen: ${res.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error al calificar el examen: ${e.toString()}');
    }
    return false;
  }

  Future<Resultados> ResultadoEstudiante(
    int id_user,
    int id_examen,
    String token,
  ) async {
    try {
      var datos = {"id_Estudiane": id_user, "id_Examen": id_examen};
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/get_estu_exa',
      );

      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(datos),
      );
      if (res.statusCode != 200) {
        print(res.statusCode);
      }
      final data = jsonDecode(res.body);
      if (data is List && data.isNotEmpty) {
        return Resultados.fromjson(data[0]);
      } else {
        return Resultados(id: 0, id_Estudiane: 0, id_Examen: 0, resultados: []);
      }
    } catch (e) {
      print('Error al cargar los resultados del estudiante: ${e.toString()}');
    }
    return Resultados(id: 0, id_Estudiane: 0, id_Examen: 0, resultados: []);
  }
}
