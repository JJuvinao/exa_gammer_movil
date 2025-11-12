import 'package:exa_gammer_movil/game/heroes/animation/recibirdanio.dart';
import 'package:exa_gammer_movil/game/heroes/controller/animation_controller.dart';
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
  final AnimacionController animController = Get.find<AnimacionController>();
  var enemyImage = "";
  var heroeImage = "";
  bool showAttackMenu = false;
  bool npcRecibioDanio = false;
  bool personajeRecibioDanio = false;
  bool mostrarMensaje = false;
  bool respuesta = false;
  bool accionEnProgreso = false;
  double atacar = 50;
  double atacarNpc = 50;
  int ataqueNum = 1;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    animController.savepj(widget.heroe);
    heroeImage = animController.posicionInicial();
    enemyImage = animController.posicionNpcInicial();
  }

  void accionatacar() {
    setState(() {
      atacar += 350;
      heroeImage = animController.posicionAtaque(ataqueNum);
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        atacar -= 350;
        heroeImage = animController.posicionInicial();
      });
    });
  }

  void accionatacarnpc() {
    setState(() {
      atacarNpc += 380;
      enemyImage = animController.posicionNpcAtaque();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        atacarNpc -= 380;
        enemyImage = animController.posicionNpcInicial();
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
                          onBasicAttack: () => {
                            showResponder(),
                            setState(() => ataqueNum = 1),
                          },
                          onSkill1: () => {
                            showResponder(),
                            setState(() => ataqueNum = 2),
                          },
                          onSkill2: () => {
                            showResponder(),
                            setState(() => ataqueNum = 3),
                          },
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
    setState(() {
      mostrarMensaje = true;
      accionEnProgreso = true;
    });
    controller.saveAtaqueNum(ataqueNum);
    if (controller.aplicarDano()) {
      setState(() => respuesta = true);
      accionatacar();
      Future.delayed(const Duration(milliseconds: 500), () {});
      setState(() {
        npcRecibioDanio = true;
      });
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          npcRecibioDanio = false;
          mostrarMensaje = false;
          accionEnProgreso = false;
        });
      });
    } else {
      setState(() => respuesta = false);
      accionatacarnpc();
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          personajeRecibioDanio = true;
        });
      });
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          setState(() {
            personajeRecibioDanio = false;
            mostrarMensaje = false;
            accionEnProgreso = false;
          });
        }
      });
    }
    //setState(() => respuesta = false);
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
      onPressed: accionEnProgreso ? null : onTap,
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
                  right: atacarNpc,
                  bottom: 20,
                  child: AnimatedBattleCharacter(
                    imagePath: enemyImage,
                    recibioDanio: npcRecibioDanio,
                    estaMuerto: controller.displayNpc.vida! <= 0,
                  ),
                ),
                //mensaje de respuesta
                Positioned.fill(
                  child: Align(
                    alignment: const Alignment(0, -0.5),
                    child: AnimatedOpacity(
                      opacity: mostrarMensaje ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        respuesta ? "¡Correcto!" : "¡Incorrecto!",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.black,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
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
