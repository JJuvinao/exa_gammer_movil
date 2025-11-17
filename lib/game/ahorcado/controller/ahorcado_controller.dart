import 'dart:convert';

import 'package:get/get.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:http/http.dart' as http;

class AhorcadoController extends GetxController {
  var palabras = <Ahorcado>[].obs;
  List<Ahorcado> palabrasRandom = [];
  var respuestas = <Respuestas_Ahorcado>[].obs;
  var palabraActual = "".obs;
  var pistaActual = "".obs;
  RxList<String> letrasUsadas = <String>[].obs;

  bool respuestaGuardada = false;

  var intentos = 0.obs;
  bool juegoActivo = true;
  String estado = "";

  int indexPalabra = 0;

  void cargarPalabras(List<Ahorcado> listaPalabras) {
    respuestas.clear();
    palabras.value = listaPalabras;

    // Mezclar palabras
    palabrasRandom = [...listaPalabras]..shuffle();

    indexPalabra = 0;
    cargarPalabraActual();
  }

  void cargarPalabraActual() {
    if (indexPalabra >= palabrasRandom.length) {
      juegoActivo = false;
      return;
    }
    respuestaGuardada = false;
    final ahorcado = palabrasRandom[indexPalabra];

    palabraActual.value = ahorcado.palabra.toLowerCase();
    pistaActual.value = ahorcado.pista;

    letrasUsadas.clear();
    intentos.value = palabraActual.value.length - 2;

    juegoActivo = true;
    estado = "";
  }

  void siguientePalabra() {
    indexPalabra++;
    cargarPalabraActual();
  }

  String renderizarPalabra() {
    return palabraActual
        .split('')
        .map((l) => letrasUsadas.contains(l) ? l : "_")
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

    if (!palabraRenderizada.contains("_") && !respuestaGuardada) {
      estado = "Ganó";
      saveResupuestas();
      juegoActivo = false;
    }

    if (intentos <= 0 && !respuestaGuardada) {
      estado = "Perdió";
      saveResupuestas();
      juegoActivo = false;
    }
  }

  void saveResupuestas() {
    if (respuestaGuardada) return;

    respuestaGuardada = true;

    final respuesta = Respuestas_Ahorcado(
      id_palabra: palabrasRandom[indexPalabra].id,
      intentos: ((palabraActual.value.length - 2) - intentos.value).abs(),
      fallos: letrasUsadas.where((l) => !palabraActual.contains(l)).length,
      aciertos: palabraActual
          .split('')
          .where((l) => letrasUsadas.contains(l))
          .length,
      acerto: estado == "Ganó",
    );

    print("Respuesta guardada: ${respuesta.toJson()}");
    respuestas.add(respuesta);
    print("numero de respuestas: ${respuestas.length}");

    // Reiniciar variables
    intentos.value = 0;
    letrasUsadas.clear();
  }

  bool get juegoTerminado => indexPalabra >= palabrasRandom.length - 1;

  Future<void> saveResultado(int id_user, String token, int id_examen) async {
    var data = {
      "id_Estudiane": id_user,
      "id_Examen": id_examen,
      "resultadoJson": jsonEncode(respuestas.map((r) => r.toJson()).toList()),
      "notas": 0,
      "recomendaciones": "",
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
        print("ERROR AL GUARDAR EL RESULTADO DEL JUEGO: ${res.statusCode}");
        print("RESPUESTA ${res.body}");
      }
      print("RESULTADO DEL JUEGO GUARDADO EXITOSAMENTE");
    } catch (e) {
      print("ERROR AL GUARDAR EL RESULTADO DEL JUEGO ${e.toString()}");
    }
  }
}
