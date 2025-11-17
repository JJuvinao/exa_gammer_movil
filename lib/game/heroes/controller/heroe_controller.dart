import 'dart:convert';
import 'package:exa_gammer_movil/game/heroes/controller/pregunta_controller.dart';
import 'package:exa_gammer_movil/game/heroes/models/npc.dart';
import 'package:exa_gammer_movil/game/heroes/models/personaje.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HeroeController extends GetxController {
  final PreguntaController preguntaController = Get.find();
  var vidaPj = 0;
  var vidaNpc = 0;
  var respuesta = "".obs;
  var ataqueNum = 0.obs;
  var dh1 = 0.obs;
  var dh2 = 0.obs;
  var dh3 = 0.obs;
  var n_gh1 = 0.obs;
  var n_gh2 = 0.obs;
  var n_gh3 = 0.obs;

  // Estado reactivo
  var pj = Personaje().obs;
  var npc = Npc().obs;

  Personaje get displayPj => pj.value;
  Npc get displayNpc => npc.value;

  void iniciar() {
    print("Controlador inicializado");
    danioHabilidad();
    n_gHabilidad();
    calcularVidaNpc();
    print("Vida NPC: ${npc.value.vida}");
    print(
      "n_gh1: ${n_gh1.value}, n_gh2: ${n_gh2.value}, n_gh3: ${n_gh3.value}",
    );
  }

  void danioHabilidad() {
    dh1.value = (pj.value.danio * 1).toInt();
    dh2.value = (pj.value.danio * 1.5).toInt();
    dh3.value = (pj.value.danio * 2).toInt();
  }

  void n_gHabilidad() {
    var n_gp = preguntaController.preguntaList.length ~/ 3;
    var residuo = preguntaController.preguntaList.length % 3;
    if (residuo != 0) {
      n_gh1.value = n_gp + 1;
    } else {
      n_gh1.value = n_gp;
    }
    n_gh2.value = n_gp;
    n_gh3.value = n_gp;
  }

  void calcularVidaNpc() {
    npc.value = Npc(
      nombre: npc.value.nombre,
      vida:
          (dh1.value * n_gh1.value) +
          (dh2.value * n_gh2.value) +
          (dh3.value * n_gh3.value),
      danio: npc.value.danio,
    );
    vidaNpc = npc.value.vida;
    vidaPj = pj.value.vida;
  }

  void saveRespuesta(String res) {
    respuesta.value = res;
  }

  void saveAtaqueNum(int num) {
    ataqueNum.value = num;
  }

  void cleanRespuesta() {
    preguntaController.respondidasList.clear();
  }

  bool preguntasVacias() {
    return preguntaController.preguntasVacias();
  }

  bool validarRespuesta() {
    return preguntaController.validarRespuesta(respuesta.value);
  }

  bool aplicarDano() {
    if (validarRespuesta()) {
      var danoCalculado = 0;
      switch (ataqueNum.value) {
        case 1:
          danoCalculado = dh1.value;
          break;
        case 2:
          danoCalculado = dh2.value;
          break;
        case 3:
          danoCalculado = dh3.value;
          break;
      }
      npc.value = Npc(
        nombre: npc.value.nombre,
        vida: (npc.value.vida - danoCalculado).clamp(0, 300),
        danio: npc.value.danio,
      );
      ataqueNum.value = 0;
      return true;
    } else {
      pj.value = Personaje(
        nombre: pj.value.nombre,
        vida: (pj.value.vida - 10).clamp(0, 300),
        danio: pj.value.danio,
      );
      return false;
    }
  }

  void restablecer() {
    pj.value = Personaje(nombre: "Same", vida: 300, danio: 50);
    npc.value = Npc(
      nombre: npc.value.nombre,
      vida:
          (dh1.value * n_gh1.value) +
          (dh2.value * n_gh2.value) +
          (dh3.value * n_gh3.value),
      danio: npc.value.danio,
    );

    displayPj.value = pj.value;
    displayNpc.value = npc.value;

    preguntaController.preguntaList.clear();
  }

  Future<void> saveResultado() async {
    print("Guardando resultado del juego...");
    print("User ID: ${preguntaController.userId.value}");
    print("Examen ID: ${preguntaController.idExamen.value}");
    print("Token: ${preguntaController.token.value}");
    var data = {
      "id_Estudiane": preguntaController.userId.value,
      "id_Examen": preguntaController.idExamen.value,
      "resultadoJson": jsonEncode(
        preguntaController.respondidasList.map((r) => r.toJson()).toList(),
      ),
      "notas": 0,
      "recomendaciones": "string",
    };
    print("Datos a enviar: $data");
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Examen/IngresarExa',
      );
      final res = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${preguntaController.token.value}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (res.statusCode != 200) {
        print("ERROR AL GUARDAR EL RESULTADO DEL JUEGO: ${res.statusCode}");
        print("RESPUESTA ${res.body}");
        return;
      }
      print("RESULTADO GUARDADO CORRECTAMENTE");
    } catch (e) {
      print("ERROR AL GUARDAR EL RESULTADO DEL JUEGO ${e.toString()}");
    }
  }
}
