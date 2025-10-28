import 'package:flutter/material.dart';

class Calificacion extends StatelessWidget {
  Calificacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Center(child: Text('Calificaciones de los Estudiantes')),
    );
  }
}
