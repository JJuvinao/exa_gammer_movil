import 'package:exa_gammer_movil/game/heroes/ui/escenario.dart';
import 'package:exa_gammer_movil/game/heroes/ui/personajes.dart';
import 'package:exa_gammer_movil/game/heroes/widget/mundocard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MundosPage extends StatefulWidget {
  final String personaje;
  const MundosPage({super.key, required this.personaje});

  @override
  State<MundosPage> createState() => _MundosPageState();
}

class _MundosPageState extends State<MundosPage> {
  final String fondo1 = "lib/game/heroes/imagenes/Fondos/fondomontaña.png";
  final String fondo2 = "lib/game/heroes/imagenes/Fondos/fondopradera.png";
  final String fondo3 = "lib/game/heroes/imagenes/Fondos/fondocastillo.jpg";
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.off(() => PersonajesPage()) ?? false,
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
                            name: "Montaña",
                            image: fondo1,
                            personaje: widget.personaje,
                            onTap: () {
                              Get.to(
                                Escenario(
                                  background: fondo1,
                                  heroe: widget.personaje,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: MundoCard(
                            name: "Pradera",
                            image: fondo2,
                            personaje: widget.personaje,
                            onTap: () {
                              Get.to(
                                Escenario(
                                  background: fondo2,
                                  heroe: widget.personaje,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                          child: MundoCard(
                            name: "Castillo",
                            image: fondo3,
                            personaje: widget.personaje,
                            onTap: () {
                              Get.to(
                                Escenario(
                                  background: fondo3,
                                  heroe: widget.personaje,
                                ),
                              );
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
