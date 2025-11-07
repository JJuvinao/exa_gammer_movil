import 'package:exa_gammer_movil/game/heroes/ui/mundos.dart';
import 'package:exa_gammer_movil/game/heroes/widget/personajecard.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PersonajesPage extends StatefulWidget {
  const PersonajesPage({super.key});

  @override
  State<PersonajesPage> createState() => _PersonajesPageState();
}

class _PersonajesPageState extends State<PersonajesPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.to(ExamenView(vista: "Examen")),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/fondo/cieloazul.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Seleccionar personajes",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: MundoCard(
                            name: "Mago",
                            image: "lib/game/heroes/imagenes/Mago/MagoIdle.gif",
                            onTap: () {
                              Get.to(MundosPage(personaje: "Mago"));
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: MundoCard(
                            name: "Guerrero",
                            image:
                                "lib/game/heroes/imagenes/Guerrero/GuerreroIdle.gif",
                            onTap: () {
                              Get.to(MundosPage(personaje: "Guerrero"));
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: MundoCard(
                            name: "Samurai",
                            image:
                                "lib/game/heroes/imagenes/Samurai/SamuraiIdle.gif",
                            onTap: () {
                              Get.to(MundosPage(personaje: "Samurai"));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
