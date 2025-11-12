import 'package:get/get.dart';

class AnimacionController extends GetxController {
  var img_pj = "".obs;
  var img_npc = "".obs;
  var pj = "".obs;
  var npc = "".obs;

  void savepj(String personaje) {
    pj.value = personaje;
  }

  void savenpc(String newnpc) {
    npc.value = newnpc;
  }

  String posicionInicial() {
    switch (pj.value) {
      case "Mago":
        img_pj.value = "lib/game/heroes/imagenes/Mago/MagoIdle.gif";
        break;
      case "Guerrero":
        img_pj.value = "lib/game/heroes/imagenes/Guerrero/GuerreroIdle.gif";
        break;
      case "Samurai":
        img_pj.value = "lib/game/heroes/imagenes/Samurai/SamuraiIdle.gif";
        break;
      default:
        img_pj.value = "";
        break;
    }

    return img_pj.value;
  }

  String posicionAtaque(int ataqueNum) {
    switch (ataqueNum) {
      case 1:
        return posicion_1();
      case 2:
        return posicion_2();
      case 3:
        return posicion_3();
      default:
        return img_pj.value = "";
    }
  }

  String posicion_1() {
    switch (pj.value) {
      case "Mago":
        img_pj.value = "lib/game/heroes/imagenes/Mago/magoATK1.gif";
        break;
      case "Guerrero":
        img_pj.value = "lib/game/heroes/imagenes/Guerrero/guerrATK1.gif";
        break;
      case "Samurai":
        img_pj.value = "lib/game/heroes/imagenes/Samurai/samuATK1.gif";
        break;
      default:
        img_pj.value = "";
        break;
    }
    return img_pj.value;
  }

  String posicion_2() {
    switch (pj.value) {
      case "Mago":
        img_pj.value = "lib/game/heroes/imagenes/Mago/magoATK2.gif";
        break;
      case "Guerrero":
        img_pj.value = "lib/game/heroes/imagenes/Guerrero/guerreroATK2.gif";
        break;
      case "Samurai":
        img_pj.value = "lib/game/heroes/imagenes/Samurai/samurariATK2.gif";
        break;
      default:
        img_pj.value = "";
        break;
    }
    return img_pj.value;
  }

  String posicion_3() {
    switch (pj.value) {
      case "Mago":
        img_pj.value = "lib/game/heroes/imagenes/Mago/magoATK3.gif";
        break;
      case "Guerrero":
        img_pj.value = "lib/game/heroes/imagenes/Guerrero/guerrATK3.gif";
        break;
      case "Samurai":
        img_pj.value = "lib/game/heroes/imagenes/Samurai/samuATK3.gif";
        break;
      default:
        img_pj.value = "";
        break;
    }
    return img_pj.value;
  }

  String posicionNpcInicial() {
    return img_npc.value = "lib/game/heroes/imagenes/Npcs/LoboIdle.gif";
  }

  String posicionNpcAtaque() {
    return img_npc.value = "lib/game/heroes/imagenes/Npcs/LoboAttack1.gif";
  }
}
