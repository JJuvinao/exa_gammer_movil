import 'dart:convert';

import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:http/http.dart' as http;

class AhorcadoController extends GetxController {
  var palabraActual = "".obs;
  var pistaActual = "".obs;
  RxList<String> letrasUsadas = <String>[].obs;
  int intentos = 6;
  bool juegoActivo = true;
  String estado = "";

  void nuevaPalabra(Ahorcado ahorcado) {
    palabraActual.value = ahorcado.palabra;
    pistaActual.value = ahorcado.pista;
  }

  void reiniciarJuego() {
    palabraActual.value = "";
    pistaActual.value = "";
    letrasUsadas.clear();
    intentos = 6;
    juegoActivo = true;
    estado = "";
  }

  String renderizarPalabra() {
    return palabraActual
        .split('')
        .map((letra) => letrasUsadas.contains(letra) ? letra : "_")
        .join(" ");
  }

  void manejarLetra(String letra) {
    if (!juegoActivo || letrasUsadas.contains(letra)) return;

    letrasUsadas.add(letra);

    if (!palabraActual.contains(letra)) {
      intentos--;
    }

    final palabraRenderizada = palabraActual
        .split('')
        .map((l) => letrasUsadas.contains(l) ? l : "_")
        .join("");

    if (!palabraRenderizada.contains("_")) {
      juegoActivo = false;
      estado = "Ganó";
    }
    if (intentos <= 0) {
      juegoActivo = false;
      estado = "Perdió";
    }
  }

  Map<String, dynamic> getResultados() {
    return {
      "aciertos": palabraActual
          .split('')
          .where((l) => letrasUsadas.contains(l))
          .length,
      "fallos": letrasUsadas.where((l) => !palabraActual.contains(l)).length,
      "intentos": intentos,
      "palabra": palabraActual,
      "estado": estado,
    };
  }

  Future<void> saveResultado(int id_user, String token, int id_examen) async {
    var rest = getResultados();
    var data = {
      'Id_Estudiane': id_user,
      'Id_Examen': id_examen,
      'Intentos': rest['intentos'],
      'Aciertos': rest['aciertos'],
      'Fallos': rest['fallos'],
      'Notas': 0,
      'Recomendaciones': "",
    };

    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/IngresarExa',
      );
      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${token}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (res.statusCode != 200) {
        print(res.statusCode);
      }
    } catch (e) {
      print("ERROR AL GUARDAR EL RESULTADO DEL JUEGO ${e.toString()}");
    }
  }
}
