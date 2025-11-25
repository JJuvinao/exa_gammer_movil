import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:exa_gammer_movil/models/juego_model.dart';

class JuegoController extends GetxController {
  final type = "Content-Type";
  final app = "application/json";
  var juegoList = <Juego>[].obs;

  Future<List<Juego>> getjuegoList() async {
    await cargarJuegos();
    if (juegoList.isEmpty) {
      return [];
    }
    return juegoList;
  }

  Future<void> cargarJuegos() async {
    try {
      final url = Uri.parse('https://www.apiexagammer.somee.com/api/juego');

      final res = await http.get(url, headers: {type: app});

      if (res.statusCode != 200) {
        print(res.body);
      }
      final data = jsonDecode(res.body);
      List<Juego> juegoListe = [];
      for (var item in data) {
        juegoListe.add(Juego.fromJson(item));
      }
      juegoList.value = juegoListe;
    } catch (e) {
      print("ERROR DE LA CARGA DE JUEGOS ${e.toString()}");
    }
  }
}
