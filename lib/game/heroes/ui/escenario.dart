import 'package:exa_gammer_movil/game/heroes/animation/recibirdanio.dart';
import 'package:exa_gammer_movil/game/heroes/controller/heroe_controller.dart';
import 'package:exa_gammer_movil/game/heroes/widget/ataques.dart';
import 'package:exa_gammer_movil/game/heroes/widget/barras_vida.dart';
import 'package:exa_gammer_movil/game/heroes/widget/pregunta.dart';
import 'package:exa_gammer_movil/game/heroes/widget/rendirse.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Escenario extends StatefulWidget {
  final String background;
  final String heroe;

  const Escenario({super.key, required this.background, required this.heroe});

  @override
  State<Escenario> createState() => _EscenarioState();
}

class _EscenarioState extends State<Escenario> {
  final HeroeController controller = Get.find<HeroeController>();
  final String enemyImage = "lib/game/heroes/imagenes/Npcs/LoboIdle.gif";
  var heroeImage = "";
  bool showAttackMenu = false;
  bool npcRecibioDanio = false;
  bool personajeRecibioDanio = false;
  var leftataquepj = 450;
  var leftinicialpj = 100;
  var leftataquenpc = 450;
  var leftinicialnpc = 50;
  double atacar = 50;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    ideHeroe();
  }

  void ideHeroe() {
    switch (widget.heroe) {
      case "Mago":
        heroeImage = "lib/game/heroes/imagenes/Mago/MagoIdle.gif";
        break;
      case "Guerrero":
        heroeImage = "lib/game/heroes/imagenes/Guerrero/GuerreroIdle.gif";
        break;
      case "Samurai":
        heroeImage = "lib/game/heroes/imagenes/Samurai/SamuraiIdle.gif";
        break;
      default:
        heroeImage = "";
        break;
    }
  }

  void ataqueHeroe() {
    switch (widget.heroe) {
      case "Mago":
        heroeImage = "lib/game/heroes/imagenes/Mago/magoATK1.gif";
        break;
      case "Guerrero":
        heroeImage = "lib/game/heroes/imagenes/Guerrero/guerrATK1.gif";
        break;
      case "Samurai":
        heroeImage = "lib/game/heroes/imagenes/Samurai/samuATK1.gif";
        break;
      default:
        heroeImage = "";
        break;
    }
  }

  void accionatacar() {
    setState(() {
      atacar += 400;
      ataqueHeroe();
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        atacar -= 400;
        ideHeroe();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await showRendirseDialog(context) ?? false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fondo/cieloazul.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              battleScene(),
              if (showAttackMenu)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AttackMenu(
                          onBasicAttack: () => showResponder(),
                          onSkill1: () => showResponder(),
                          onSkill2: () => showResponder(),
                          onCancel: () {
                            setState(() {
                              showAttackMenu = false;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void showResponder() async {
    setState(() => showAttackMenu = false);

    await Get.to(
      PreguntaDialog(
        questionText:
            '¿Cuál de las siguientes estructuras de control en Python se utiliza para ejecutar un bloque de código repetidamente mientras una condición sea verdadera?',
      ),
    );
    if (controller.aplicarDano()) {
      accionatacar();
      Future.delayed(const Duration(milliseconds: 2000), () {});
      setState(() => npcRecibioDanio = true);
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          npcRecibioDanio = false;
        });
      });
    } else {
      setState(() => personajeRecibioDanio = true);
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          personajeRecibioDanio = false;
        });
      });
    }
    if (controller.npc.value.vida! <= 0) {
      Get.defaultDialog(
        title: "¡Victoria! 🎉",
        middleText: "Has derrotado al enemigo",
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            controller.restablecer();
            setState(() {});
          },
          child: Text("Reiniciar combate"),
        ),
      );
    }
    if (controller.pj.value.vida! <= 0) {
      Get.defaultDialog(
        title: "Derrota 💀",
        middleText: "Tu personaje ha sido derrotado",
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            controller.restablecer();
            setState(() {});
          },
          child: Text("Reiniciar combate"),
        ),
      );
    }
  }

  void showSurrenderDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return RendirseDialog(
          onConfirm: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
            Navigator.pop(context);
            Get.off(() => ExamenView(vista: "Examen"));
          },
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  Widget botonAccion(String titulo, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(titulo),
    );
  }

  Widget battleScene() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  widget.background,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                //Barra de vida del enemigo
                Positioned(
                  top: 10,
                  right: 30,
                  child: Obx(
                    () => LifeBar(
                      currentHp: controller.npc.value.vida!.toDouble(),
                      maxHp: 300,
                      width: 250,
                      height: 25,
                    ),
                  ),
                ),
                //Barra de vida del jugador
                Positioned(
                  top: 10,
                  left: 30,
                  child: Obx(
                    () => LifeBar(
                      currentHp: controller.pj.value.vida!.toDouble(),
                      maxHp: 300,
                      width: 250,
                      height: 25,
                    ),
                  ),
                ),

                //Personaje
                Positioned(
                  left: atacar,
                  bottom: 20,
                  child: AnimatedBattleCharacter(
                    imagePath: heroeImage,
                    recibioDanio: personajeRecibioDanio,
                    estaMuerto: controller.displayPj.vida! <= 0,
                  ),
                ),

                //Enemigo
                Positioned(
                  right: 50,
                  bottom: 20,
                  child: AnimatedBattleCharacter(
                    imagePath: enemyImage,
                    recibioDanio: npcRecibioDanio,
                    estaMuerto: controller.displayNpc.vida! <= 0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black26,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botonAccion("Atacar", () {
                  setState(() => showAttackMenu = true);
                }),
                botonAccion("Defender", () {}),
                botonAccion("Rendirse", showSurrenderDialog),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
