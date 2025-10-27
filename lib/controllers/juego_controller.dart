import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:exa_gammer_movil/models/juego_model.dart';

class JuegoController extends GetxController {
  var juegoList = <Juego>[].obs;

  Future<List<Juego>> getjuegoList() async {
    await CargarJuegos();
    if (juegoList.isEmpty) {
      return [];
    }
    return juegoList;
  }

  Future<void> CargarJuegos() async {
    try {
      final url = Uri.parse('https://apiexagammer.somee.com/api/juego');

      final res = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode != 200) {
        print(res.body);
      }
      final data = jsonDecode(res.body);
      List<Juego> _JuegoList = [];
      for (var item in data) {
        _JuegoList.add(Juego.fromJson(item));
      }
      juegoList.value = _JuegoList;
    } catch (e) {
      print("ERROR DE LA CARGA DE JUEGOS ${e.toString()}");
    }
  }
}
