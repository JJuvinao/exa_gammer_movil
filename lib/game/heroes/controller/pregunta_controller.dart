import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:get/get.dart';
import 'dart:math';

class PreguntaController extends GetxController {
  var preguntaList = <Heroes>[].obs;
  var respondidasList = <Respuestas_Heroes>[].obs;
  var userId = 0.obs;
  var token = ''.obs;
  var idExamen = 0.obs;
  var pregunta = Heroes(
    id: 0,
    pregunta: '',
    respuesta: '',
    respuestaf1: '',
    respuestaf2: '',
    respuestaf3: '',
    codigo_exa: '',
  ).obs;

  void cargarPreguntas(
    List<Heroes> preguntas,
    int userId,
    String token,
    int idExamen,
  ) async {
    preguntaList.clear();
    respondidasList.clear();
    preguntaList.addAll(preguntas);
    this.userId.value = userId;
    this.token.value = token;
    this.idExamen.value = idExamen;
    print("Preguntas cargadas: ${preguntaList.length}");
  }

  bool preguntasVacias() {
    return preguntaList.isEmpty;
  }

  void clearRespuestas() {
    respondidasList.clear();
  }

  int generarNumeroAleatorio(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

  Heroes obtenerPregunta() {
    if (preguntaList.isEmpty) {
      return Heroes(
        id: 0,
        pregunta: 'No hay más preguntas disponibles',
        respuesta: '',
        respuestaf1: '',
        respuestaf2: '',
        respuestaf3: '',
        codigo_exa: '0',
      );
    }
    if (preguntaList.length == 1) {
      pregunta.value = preguntaList[0];
      preguntaList.removeAt(0);
      print("Preguntas nuevas: ${preguntaList.length}");
      return pregunta.value;
    }
    int indiceAleatorio = generarNumeroAleatorio(0, preguntaList.length - 1);
    pregunta.value = preguntaList[indiceAleatorio];
    preguntaList.removeAt(indiceAleatorio);
    print("Preguntas nuevas: ${preguntaList.length}");
    return pregunta.value;
  }

  bool validarRespuesta(String res) {
    var responder = Respuestas_Heroes(
      id_pregunta: pregunta.value.id,
      respuesta: res,
    );
    respondidasList.add(responder);
    print("Respuestas dadas: ${respondidasList.length}");
    print("Id de la pregunta: ${pregunta.value.id}, Respuesta dada: ${res}");
    if (res == pregunta.value.respuesta) {
      return true;
    } else {
      return false;
    }
  }
}
