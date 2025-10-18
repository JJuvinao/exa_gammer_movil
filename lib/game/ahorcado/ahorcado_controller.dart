import 'dart:math';
import 'package:get/get.dart';

class PalabraConPista {
  final String palabra;
  final String pista;

  PalabraConPista({required this.palabra, required this.pista});
}

class AhorcadoController extends GetxController {
  final List<PalabraConPista> palabrasConPista = [
    PalabraConPista(
      palabra: "programacion",
      pista: "Disciplina de crear software y aplicaciones.",
    ),
    PalabraConPista(
      palabra: "javascript",
      pista: "Lenguaje de programación muy usado en la web.",
    ),
    PalabraConPista(
      palabra: "computadora",
      pista: "Dispositivo electrónico para procesar datos.",
    ),
    PalabraConPista(
      palabra: "desarrollo",
      pista: "Proceso de creación y mejora de software.",
    ),
    PalabraConPista(
      palabra: "internet",
      pista: "Red global que conecta millones de computadoras.",
    ),
    PalabraConPista(
      palabra: "algoritmo",
      pista: "Conjunto de pasos para resolver un problema.",
    ),
    PalabraConPista(
      palabra: "variable",
      pista: "Espacio donde se almacena información temporalmente.",
    ),
    PalabraConPista(
      palabra: "funcion",
      pista: "Bloque de código reutilizable que realiza una tarea.",
    ),
    PalabraConPista(
      palabra: "react",
      pista: "Librería de JavaScript para construir interfaces de usuario.",
    ),
    PalabraConPista(
      palabra: "frontend",
      pista: "Parte visual de una aplicación web, vista por el usuario.",
    ),
    PalabraConPista(
      palabra: "constitucion",
      pista: "Conjunto de leyes fundamentales de un país.",
    ),
    PalabraConPista(
      palabra: "arqueologia",
      pista:
          "Ciencia que estudia las civilizaciones antiguas a través de sus restos.",
    ),
    PalabraConPista(
      palabra: "biodiversidad",
      pista: "Variedad de especies animales y vegetales en un entorno.",
    ),
    PalabraConPista(
      palabra: "democracia",
      pista: "Sistema político donde el pueblo elige a sus gobernantes.",
    ),
    PalabraConPista(
      palabra: "filosofia",
      pista:
          "Disciplina que estudia cuestiones fundamentales sobre la existencia y el conocimiento.",
    ),
    PalabraConPista(
      palabra: "literatura",
      pista: "Arte de la expresión escrita o hablada.",
    ),
    PalabraConPista(
      palabra: "astronomia",
      pista: "Ciencia que estudia los astros y el universo.",
    ),
    PalabraConPista(
      palabra: "prehistoria",
      pista: "Período anterior a la invención de la escritura.",
    ),
    PalabraConPista(
      palabra: "ecosistema",
      pista: "Conjunto de seres vivos y su entorno natural.",
    ),
    PalabraConPista(
      palabra: "mitologia",
      pista: "Conjunto de mitos y leyendas de una cultura.",
    ),
  ].obs;

  late String palabraActual;
  late String pistaActual;
  RxList<String> letrasUsadas = <String>[].obs;
  int intentos = 6;
  bool juegoActivo = true;
  String estado = "";
  final RxList<String> palabrasUsadas = <String>[].obs;

  AhorcadoController() {
    nuevaPalabra();
  }

  void nuevaPalabra() {
    final disponibles = palabrasConPista
        .where((p) => !palabrasUsadas.contains(p.palabra))
        .toList();

    final seleccion = disponibles.isEmpty
        ? palabrasConPista[Random().nextInt(palabrasConPista.length)]
        : disponibles[Random().nextInt(disponibles.length)];

    palabraActual = seleccion.palabra;
    pistaActual = seleccion.pista;
    letrasUsadas = <String>[].obs;
    palabrasUsadas.add(palabraActual);
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
    } else if (intentos <= 0) {
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
    };
  }
}
