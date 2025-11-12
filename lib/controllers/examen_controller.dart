import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExamenController extends GetxController {
  var ExamenList = <Examen>[].obs;
  var ResultadosList = <Resultados>[].obs;
  var UserResult = <Userto>[].obs;
  var HeroesList = <Heroes>[].obs;
  final _storageService = Get.find<StorageService>();

  Examen get getexamen => _storageService.displayExamen;
  Ahorcado get getcontextahorcado => _storageService.displayAhorcado;

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
    ExamenList.add(actividad);
  }

  void deleteExamen(int index) {
    ExamenList.removeAt(index);
  }

  void clearExamen() {
    ExamenList.clear();
  }

  Future<List<Examen>> filteredList(int id, String token) async {
    await CargarExamenes(id, token);
    if (ExamenList.isEmpty) {
      return [];
    }
    return ExamenList;
  }

  Future<List<Heroes>> listaHeroes(String codigo, String token) async {
    await CargarHeroes(codigo, token);
    if (HeroesList.isEmpty) {
      return [];
    }
    return HeroesList;
  }

  Future<List<Estudi_Resultados>> listresult(
    int id_user,
    int id_examen,
    String token,
  ) async {
    await Resultados_Estu(id_examen, token);
    await Estudiantes_Result(id_examen, token);
    if (ResultadosList.isEmpty || UserResult.isEmpty) {
      return [];
    }

    var Estu_Result = <Estudi_Resultados>[];
    for (int i = 0; i < ResultadosList.length; i++) {
      if (ResultadosList[i].id_Estudiane == UserResult[i].id) {
        var estu = Estudi_Resultados(
          id: ResultadosList[i].id,
          id_Estudiante: UserResult[i].id,
          Nombre: UserResult[i].username,
          correo: UserResult[i].email,
          img: UserResult[i].img!,
          id_Examen: ResultadosList[i].id_Examen,
          intentos: ResultadosList[i].intentos,
          aciertos: ResultadosList[i].aciertos,
          fallos: ResultadosList[i].fallos,
          nota: ResultadosList[i].nota,
          recomendacion: ResultadosList[i].recomendacion,
        );
        Estu_Result.add(estu);
      }
      ;
    }
    return Estu_Result;
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
      urls = 'https://www.apiexagammer.somee.com/api/Examenes/Ahorcado';
      datosExamen = {
        'Nombre': examen['Nombre'],
        'Tema': examen['Tema'],
        'Autor': examen['Autor'],
        'Descripcion': examen['Descripcion'],
        'ImagenExamen': examen['ImagenExamen'],
        'Id_Clase': examen['Id_Clase'],
        'Id_Juego': examen['Id_Juego'],
        'Palabra': datos['palabra'],
        'Pista': datos['pista'],
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
      HeroesList.value = heroeList;
    } catch (e) {
      print("ERROR EN CARGAR HEROES ${e.toString()}");
    }
  }

  Future<dynamic> CargarContenido(
    int id_juego,
    String token,
    String codigo,
  ) async {
    String urls = '';
    if (id_juego == 1) {
      urls =
          "https://www.apiexagammer.somee.com/api/Examenes/GetAhorcado/${codigo}";
    } else {
      urls =
          "https://www.apiexagammer.somee.com/api/Examenes/GetHeroes/${codigo}";
    }

    try {
      final url = Uri.parse(urls);

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
      return data;
    } catch (e) {
      print("ERROR EN CARGAR CONTENIDO ${e.toString()}");
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
      ResultadosList.value = resulList;
    } catch (e) {
      print('Error al cargar el contenido del examen: ${e.toString()}');
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
      UserResult.value = resulList;
    } catch (e) {
      print('Error al guardar el examen: ${e.toString()}');
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
}
