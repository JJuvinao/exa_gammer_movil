import 'package:exa_gammer_movil/game/heroes/widget/ataques.dart';
import 'package:exa_gammer_movil/game/heroes/widget/barras_vida.dart';
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
  final String enemyImage = "lib/game/heroes/imagenes/Npcs/LoboIdle.gif";
  var heroeImage = "";
  bool showAttackMenu = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    cargarheroe();
  }

  void cargarheroe() {
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
                          onBasicAttack: () {
                            print("Ataque básico");
                            setState(() => showAttackMenu = false);
                          },
                          onSkill1: () {
                            print("Habilidad 1");
                            setState(() => showAttackMenu = false);
                          },
                          onSkill2: () {
                            print("Habilidad 2");
                            setState(() => showAttackMenu = false);
                          },
                          onCancel: () {
                            setState(() => showAttackMenu = false);
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
          onCancel: () {
            Navigator.pop(context);
          },
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
                //enemigo
                Positioned(
                  top: 10,
                  right: 30,
                  child: LifeBar(
                    currentHp: 100,
                    maxHp: 300,
                    width: 250,
                    height: 25,
                  ),
                ),
                //heroe
                Positioned(
                  top: 10,
                  right: 500,
                  child: LifeBar(
                    currentHp: 50,
                    maxHp: 300,
                    width: 250,
                    height: 25,
                  ),
                ),

                /// Personaje
                Positioned(
                  left: 50,
                  bottom: 20,
                  child: Image.asset(heroeImage, height: 200),
                ),

                /// Enemigo
                Positioned(
                  right: 50,
                  bottom: 20,
                  child: Image.asset(enemyImage, height: 200),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.black26, // opcional
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                botonAccion("Atacar", () {
                  setState(() => showAttackMenu = true);
                }),
                botonAccion("Defender", () {}),
                botonAccion("Rendirse", () {
                  showSurrenderDialog();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
