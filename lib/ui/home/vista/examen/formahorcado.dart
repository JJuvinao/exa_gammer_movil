import 'package:flutter/material.dart';

class AhorcadoForm extends StatefulWidget {
  const AhorcadoForm({super.key});

  @override
  State<AhorcadoForm> createState() => AhorcadoFormState();
}

class AhorcadoFormState extends State<AhorcadoForm> {
  final _formKey = GlobalKey<FormState>();
  final _palabraController = TextEditingController();
  final _pistaController = TextEditingController();

  Map<String, String>? getData() {
    if (_formKey.currentState!.validate()) {
      return {
        'palabra': _palabraController.text.trim(),
        'pista': _pistaController.text.trim(),
      };
    }
    return null; // si no pasa la validación
  }

  @override
  Widget build(BuildContext context) {
    // Tamaño de pantalla (para hacerlo responsive)
    final size = MediaQuery.of(context).size;
    final isHorizontal = size.width > size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagen superior
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/avatars/ahorcado.png', // 👈 Asegúrate de agregar la imagen en assets
                    width: isHorizontal ? size.width * 0.3 : size.width * 0.7,
                    height: isHorizontal ? 200 : 250,
                    fit: BoxFit.contain,
                  ),
                ),

                // Campo Palabra
                TextFormField(
                  controller: _palabraController,
                  decoration: const InputDecoration(
                    labelText: "Palabra",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ingrese una palabra'
                      : null,
                ),
                const SizedBox(height: 16),

                // Campo Pista
                TextFormField(
                  controller: _pistaController,
                  decoration: const InputDecoration(
                    labelText: "Pista",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lightbulb_outline),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ingrese una pista'
                      : null,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
