import 'package:exa_gammer_movil/game/heroes/models/npc.dart';
import 'package:exa_gammer_movil/game/heroes/models/personaje.dart';
import 'package:get/get.dart';

class HeroeController extends GetxController {
  var respuesta = "".obs;
  var ataqueNum = 0.obs;

  // Estado reactivo
  var pj = Personaje(nombre: "Same", vida: 300, defensa: 20).obs;
  var npc = Npc(nombre: "Lobo", vida: 300, defensa: 20).obs;

  Personaje get displayPj => pj.value;
  Npc get displayNpc => npc.value;

  void saveRespuesta(String res) {
    respuesta.value = res;
  }

  void saveAtaqueNum(int num) {
    ataqueNum.value = num;
  }

  void cleanRespuesta() {
    respuesta.value = "";
  }

  bool validarRespuesta() {
    return respuesta.value == "while";
  }

  bool aplicarDano() {
    if (validarRespuesta()) {
      var danoCalculado = 50;
      switch (ataqueNum.value) {
        case 1:
          danoCalculado = 50;
          break;
        case 2:
          danoCalculado = (danoCalculado * 1.5).toInt();
          break;
        case 3:
          danoCalculado = (danoCalculado * 2).toInt();
          break;
      }
      npc.value = Npc(
        nombre: npc.value.nombre,
        vida: (npc.value.vida! - danoCalculado).clamp(0, 300),
        defensa: npc.value.defensa,
      );
      cleanRespuesta();
      ataqueNum.value = 0;
      return true;
    } else {
      pj.value = Personaje(
        nombre: pj.value.nombre,
        vida: (pj.value.vida! - 50).clamp(0, 300),
        defensa: pj.value.defensa,
      );
      cleanRespuesta();
      return false;
    }
  }

  void restablecer() {
    pj.value = Personaje(nombre: "Same", vida: 300, defensa: 20);
    npc.value = Npc(nombre: "Lobo", vida: 300, defensa: 20);

    displayPj.value = pj.value;
    displayNpc.value = npc.value;
  }
}
