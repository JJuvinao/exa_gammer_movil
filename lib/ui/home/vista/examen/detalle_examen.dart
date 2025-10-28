import 'package:auto_size_text/auto_size_text.dart';
import 'package:exa_gammer_movil/game/ahorcado/ahorcado_page.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetalleExamenPage extends StatefulWidget {
  const DetalleExamenPage({super.key});

  @override
  State<DetalleExamenPage> createState() => _DetalleExamenPageState();
}

class _DetalleExamenPageState extends State<DetalleExamenPage> {
  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cerrar sesión'),
            content: const Text('¿Desea cerrar sesión?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(() => Vistalogin()); // Limpia todo el stack
                },
                child: const Text('Sí'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget build(BuildContext context) {
    final examen = {
      "titulo": "prueba conte",
      "codigo": "5F60E4",
      "fecha": "15/10/2025",
      "descripcion": "dwadawd",
      "palabra": "conte",
      "respuestaCorrecta": "pista conte 2",
    };

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFFC8C1C1),
        appBar: AppBar(
          backgroundColor: const Color(0xFFC8C1C1),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/imagen/logo_exa.png', height: 75),
                      const SizedBox(width: 12),
                      Flexible(
                        child: AutoSizeText(
                          examen['titulo']!,
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
                                  examen['titulo']!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text("Código: ${examen['codigo']}"),
                                Text("Fecha: ${examen['fecha']}"),
                                Text("Descripción: ${examen['descripcion']}"),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => AhorcadoPage());
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
                                Text("Palabra: ${examen['palabra']}"),
                                Text(
                                  "Respuesta correcta: ${examen['respuestaCorrecta']}",
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // === RESULTADOS DEL EXAMEN ===
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Resultados del Examen",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text("No hay resultados para mostrar."),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // === ESTUDIANTES REGISTRADOS ===
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Estudiantes registrados en la clase",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: DataTable(
                                    headingRowColor: WidgetStateProperty.all(
                                      Colors.grey.shade200,
                                    ),
                                    columns: const [
                                      DataColumn(label: Text("N°")),
                                      DataColumn(label: Text("Nombre")),
                                    ],
                                    rows: const [
                                      DataRow(
                                        cells: [
                                          DataCell(Text("—")),
                                          DataCell(
                                            Text(
                                              "No hay estudiantes registrados.",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
    );
  }
}
