import 'package:flutter/material.dart';

class DetalleExamenPage extends StatelessWidget {
  const DetalleExamenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final examen = {
      "titulo": "prueba conte",
      "codigo": "5F60E4",
      "fecha": "15/10/2025",
      "descripcion": "dwadawd",
      "palabra": "conte",
      "respuestaCorrecta": "pista conte 2",
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text(
          "Exa-Gammer - Examen: ${examen['titulo']}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Volver al menú",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // ignore: unused_local_variable
          final isWide = constraints.maxWidth > 700;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
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
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Text("Ingresar al Examen"),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Volver"),
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
                                border: Border.all(color: Colors.grey.shade300),
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
                                        Text("No hay estudiantes registrados."),
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
            ),
          );
        },
      ),
    );
  }
}
