import 'package:auto_size_text/auto_size_text.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/game/ahorcado/ahorcado_page.dart';
import 'package:exa_gammer_movil/game/heroes/ui/personajes.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/clase_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetalleExamenPage extends StatefulWidget {
  const DetalleExamenPage({super.key});

  @override
  State<DetalleExamenPage> createState() => _DetalleExamenPageState();
}

class _DetalleExamenPageState extends State<DetalleExamenPage> {
  late final ExamenController pc;
  late final UserController user;

  var examen;
  Ahorcado ahorcado = Ahorcado(palabra: "", pista: "");

  @override
  void initState() {
    super.initState();
    pc = Get.find();
    user = Get.find();
    examen = pc.getexamen;
    cargarContenido();
  }

  void cargarContenido() async {
    var contenido = await pc.CargarContenido(
      examen.id_juego,
      user.gettoken,
      examen.codigo,
    );
    setState(() {
      if (examen.id_juego == 1) {
        pc.saveContExaAhorcado(Ahorcado.fromjson(contenido));
        ahorcado = Ahorcado.fromjson(contenido);
      } else {
        print(contenido);
      }
    });
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await Get.to(ClaseView(vista: "Clase")),
      child: Scaffold(
        backgroundColor: const Color(0xFFC8C1C1),
        appBar: AppBar(
          backgroundColor: const Color(0xFFC8C1C1),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/imagen/logo_exa.png', height: 75),
                        const SizedBox(width: 12),
                        Flexible(
                          child: AutoSizeText(
                            "Examen",
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: "TitanOne",
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            minFontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // === SECCIÓN DE INFORMACIÓN GENERAL ===
                          Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${examen.nombre}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(
                                            () => PersonajesPage(),

                                            /*AhorcadoPage(
                                            ahorcado: ahorcado,
                                            id_user: user.getuser.id,
                                            token: user.gettoken,
                                            id_examen: examen.id,
                                          ),*/
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 30,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Ingresar al Examen",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // === CONTENIDO DEL EXAMEN ===
                          Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Contenido del Examen",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text("Palabra: ${ahorcado.palabra}"),
                                  const SizedBox(height: 8),
                                  Text("Pista: ${ahorcado.pista}"),
                                ],
                              ),
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
      ),
    );
  }
}
