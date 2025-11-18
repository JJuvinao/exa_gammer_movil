import 'package:exa_gammer_movil/models/examen_model.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/widget/listAhorcados.dart';
import 'package:flutter/material.dart';

class AhorcadoForm extends StatefulWidget {
  const AhorcadoForm({super.key});

  @override
  State<AhorcadoForm> createState() => AhorcadoFormState();
}

class AhorcadoFormState extends State<AhorcadoForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _palabraController = TextEditingController();
  final TextEditingController _pistaController = TextEditingController();

  final List<Map<String, String>> _palabras = [];

  Map<String, dynamic>? getData() {
    return {'listaAhorcado': _palabras};
  }

  void _agregarPalabra() {
    if (_formKey.currentState!.validate()) {
      final palabra = {
        'palabra': _palabraController.text.trim(),
        'pista': _pistaController.text.trim(),
      };

      setState(() {
        _palabras.add(palabra);
        _palabraController.clear();
        _pistaController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Palabra agregada correctamente")),
      );
    }
  }

  List<Ahorcado> getAhorcadoList() {
    return _palabras.map((palabra) {
      return Ahorcado(
        id: 0,
        palabra: palabra['palabra']!,
        pista: palabra['pista']!,
        codigo_exa: '',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isHorizontal = size.width > size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(
                    'assets/avatars/ahorcado.png',
                    width: isHorizontal ? size.width * 0.3 : size.width * 0.7,
                    height: isHorizontal ? 200 : 250,
                    fit: BoxFit.contain,
                  ),
                ),

                TextFormField(
                  controller: _palabraController,
                  decoration: const InputDecoration(
                    labelText: "Palabra",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Ingrese una palabra'
                      : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _pistaController,
                  decoration: const InputDecoration(
                    labelText: "Pista",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lightbulb_outline),
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Ingrese una pista'
                      : null,
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _agregarPalabra,
                        icon: const Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        label: const Text("Agregar Palabra"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Palabras agregadas:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 12),

                if (_palabras.isEmpty)
                  const Text(
                    "No hay palabras agregadas.",
                    style: TextStyle(color: Colors.grey),
                  ),

                if (_palabras.isNotEmpty)
                  ListaAhorcadosView(ahorcadoList: getAhorcadoList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
