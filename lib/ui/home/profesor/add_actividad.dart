import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/actividad_controller.dart';
import 'package:exa_gammer_movil/models/actividad_model.dart';

class AddActividad extends StatelessWidget {
  AddActividad({super.key});

  final ExamenController actividadController = Get.find();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController temaController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  final RxString tipoSeleccionado = ''.obs;

  final List<String> tiposJuego = ['Juego', 'Evaluación'];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo y título
              Row(
                children: [
                  Image.asset('assets/imagen/logo_exa.png', height: 75),
                  const SizedBox(width: 12),
                  const Text(
                    'EXA-GAMMER',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: "TitanOne",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Contenedor del formulario
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Agregar Actividad',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Campo: Nombre
                      TextFormField(
                        controller: nombreController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Ingrese un nombre'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Campo: Tema
                      TextFormField(
                        controller: temaController,
                        decoration: const InputDecoration(
                          labelText: 'Tema',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Ingrese un tema'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Campo: Descripción
                      TextFormField(
                        controller: descripcionController,
                        decoration: const InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Ingrese una descripción'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Dropdown: Tipo
                      Obx(() {
                        return DropdownButtonFormField<String>(
                          value: tipoSeleccionado.value.isEmpty
                              ? null
                              : tipoSeleccionado.value,
                          items: tiposJuego.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo,
                              child: Text(tipo),
                            );
                          }).toList(),
                          onChanged: (value) {
                            tipoSeleccionado.value = value ?? '';
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tipo de Actividad',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Seleccione un tipo'
                              : null,
                        );
                      }),

                      const SizedBox(height: 24),

                      // Botón: Guardar
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final nuevaActividad = null;

                              actividadController.addExamen(nuevaActividad);

                              Get.back();

                              Get.snackbar(
                                'Actividad Agregada',
                                'La actividad fue registrada exitosamente.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green[100],
                                colorText: Colors.black87,
                              );
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Guardar Actividad'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
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
  }
}
