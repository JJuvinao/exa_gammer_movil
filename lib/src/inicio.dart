import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/src/navbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Gammer',
        botones: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/registro');
            },
            child: const Text(
              'Registrarse',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6), // Fondo semitransparente
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  // 1. Fondo de imagen que ocupa todo el espacio
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 2. Contenedor con el texto a la izquierda
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right:
                        MediaQuery.of(context).size.width /
                        15 *
                        5, // Ocupa 1/3 de la pantalla
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.7,
                          ), // Fondo semitransparente
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Text(
                          'Conocimiento sin límites, educación para todos.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6), // Fondo semitransparente
                border: Border.all(
                  color: Colors.black.withOpacity(0.3),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  // 1. Fondo de imagen que ocupa todo el espacio
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/c.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // 2. Contenedor con el texto a la izquierda
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left:
                        MediaQuery.of(context).size.width /
                        20 *
                        4, // Ocupa la mitad derecha
                    right: 0,
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(
                            0.7,
                          ), // Fondo semitransparente
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Text(
                          'Creemos que la educación debe ser un derecho accesible para todos. Nuestro enfoque está centrado en proporcionar un aprendizaje de calidad que fomente el desarrollo académico y personal de cada estudiante...',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
