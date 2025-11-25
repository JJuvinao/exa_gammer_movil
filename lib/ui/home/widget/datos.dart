import 'package:flutter/material.dart';

class DatosScreen extends StatelessWidget {
  const DatosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Sección de Datos',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
