import 'package:exa_gammer_movil/controllers/clase_controller.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/models/juego_model.dart';
import 'package:exa_gammer_movil/ui/home/widget/avatares.dart';

import 'formahorcado.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/formheroes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/examen_controller.dart';
import 'package:exa_gammer_movil/controllers/juego_controller.dart';

class AddExamen extends StatefulWidget {
  AddExamen({super.key});

  @override
  State<AddExamen> createState() => _AddExamenState();
}

class _AddExamenState extends State<AddExamen> {
  final ExamenController actividadController = Get.find();

  final GlobalKey<AhorcadoFormState> ahorcadoFormKey =
      GlobalKey<AhorcadoFormState>();

  final GlobalKey<HeroesFormState> heroesFormKey = GlobalKey<HeroesFormState>();

  final UserController userController = Get.find();

  final ClaseController claseController = Get.find();

  final JuegoController juegoController = Get.find();

  final TextEditingController nombreController = TextEditingController();

  final TextEditingController temaController = TextEditingController();

  final TextEditingController descripcionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var tiposJuego = <dynamic>[].obs;
  bool mostaravatar = false;
  String? selecionAvatar;

  final List<String> avatarList = [
    "assets/fondo/cieloatardecer.jpg",
    "assets/fondo/cieloazul.jpg",
    "assets/fondo/cielomorado.jpg",
    "assets/fondo/cielonoche.jpg",
    "assets/fondo/fondo1.jpg",
  ];

  @override
  void initState() {
    super.initState();
    tiposJuego.refresh();
    CargarJuego();
  }

  void CargarJuego() async {
    tiposJuego.value = await juegoController.getjuegoList();
  }

  @override
  Widget build(BuildContext context) {
    final Rxn<Juego> JuegoSeleccionado = Rxn<Juego>();

    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC8C1C1),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        'Agregar Examen',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

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

                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (mostaravatar == true)
                              ClipOval(
                                child: Image.asset(
                                  selecionAvatar!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            const SizedBox(height: 16),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              onPressed: () async {
                                final avatar = await AvatarSelectorModal.show(
                                  context,
                                  avatarList,
                                );
                                if (avatar != null) {
                                  setState(() {
                                    selecionAvatar = avatar;
                                    mostaravatar = true;
                                  });
                                }
                              },
                              child: const Text('Elegir avatar'),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Dropdown: Tipo
                      Obx(() {
                        return DropdownButtonFormField<dynamic>(
                          value: JuegoSeleccionado.value == null
                              ? null
                              : JuegoSeleccionado.value,
                          items: tiposJuego.map((tipo) {
                            return DropdownMenuItem(
                              value: tipo,
                              child: Text(tipo.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {
                            JuegoSeleccionado.value = value;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tipo de Juego',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value == null ? 'Seleccione un tipo' : null,
                        );
                      }),

                      const SizedBox(height: 24),
                      Obx(() {
                        if (JuegoSeleccionado.value?.id == 1) {
                          return AhorcadoForm(key: ahorcadoFormKey);
                        }
                        if (JuegoSeleccionado.value?.id == 2) {
                          return HeroesForm(key: heroesFormKey);
                        }
                        return const Text('Seleccione un tipo de examen');
                      }),
                      const SizedBox(height: 24),
                      const Text(
                        'Después de completar el formulario, presione "Guardar Examen" para registrar el nuevo examen.',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),

                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;

                            Map<String, dynamic>? datos;

                            if (JuegoSeleccionado.value?.id == 1) {
                              datos = ahorcadoFormKey.currentState?.getData();
                              if (datos == null) return;
                            }
                            if (JuegoSeleccionado.value?.id == 2) {
                              datos = heroesFormKey.currentState?.getData();
                              if (datos == null ||
                                  datos['lispreheroe'].length < 5) {
                                Get.snackbar(
                                  'Error',
                                  'Debe agregar al menos 5 preguntas.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red[100],
                                  colorText: Colors.black,
                                );
                                return;
                              }
                            }

                            Map<dynamic, dynamic> datosExamen = {};
                            if (datos != null) {
                              if (JuegoSeleccionado.value?.id == 2) {
                                datosExamen = {
                                  'tipo': 'heroes',
                                  'datos': datos,
                                };
                              } else if (JuegoSeleccionado.value?.id == 1) {
                                datosExamen = {
                                  'tipo': 'ahorcado',
                                  'datos': datos,
                                };
                              }
                            }

                            final examen = {
                              'Nombre': nombreController.text,
                              'Tema': temaController.text,
                              'Autor': userController.getuser.username,
                              'Descripcion': descripcionController.text,
                              'ImagenExamen': "/avatars/avatar1.jpg",
                              'Id_Clase': claseController.getclase.id,
                              'Id_Juego': JuegoSeleccionado.value?.id,
                            };

                            var res = await actividadController.guardarExamen(
                              examen,
                              datosExamen,
                              userController.gettoken,
                            );
                            Get.back();
                            if (res) {
                              Get.snackbar(
                                'Examen Agregado',
                                'El examen fue registrado exitosamente.',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green[100],
                                colorText: Colors.black87,
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                'Hubo un problema al guardar el examen',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red[100],
                                colorText: Colors.black87,
                              );
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Guardar Examen'),
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
