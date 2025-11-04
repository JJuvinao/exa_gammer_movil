import 'package:exa_gammer_movil/game/heroes/widget/personajecard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonajesPage extends StatefulWidget {
  const PersonajesPage({super.key});

  @override
  State<PersonajesPage> createState() => _PersonajesPageState();
}

class _PersonajesPageState extends State<PersonajesPage> {
  @override
  void initState() {
    super.initState();

    // Forzar horizontal
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Restaurar orientación al salir
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 900
                        ? 3
                        : 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      PersonajeCard(
                        name: "Mago",
                        image: "lib/game/heroes/imagenes/Mago/MagoIdle.gif",
                        onTap: () {},
                      ),
                      PersonajeCard(
                        name: "Guerrero",
                        image:
                            "lib/game/heroes/imagenes/Guerrero/GuerreroIdle.gif",
                        onTap: () {},
                      ),
                      PersonajeCard(
                        name: "Samurai",
                        image:
                            "lib/game/heroes/imagenes/Samurai/SamuraiIdle.gif",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
