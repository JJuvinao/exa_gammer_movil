import 'package:flutter/material.dart';

class HeroesForm extends StatefulWidget {
  const HeroesForm({super.key});

  @override
  State<HeroesForm> createState() => HeroesFormState();
}

class HeroesFormState extends State<HeroesForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _preguntaController = TextEditingController();
  final TextEditingController _respuestaVController = TextEditingController();
  final TextEditingController _respuesta1Controller = TextEditingController();
  final TextEditingController _respuesta2Controller = TextEditingController();
  final TextEditingController _respuesta3Controller = TextEditingController();

  final List<Map<String, String>> _preguntas = [];

  void _agregarPregunta() {
    if (_formKey.currentState!.validate()) {
      final pregunta = {
        "Pregunta": _preguntaController.text,
        "RespuestaV": _respuestaVController.text,
        "RespuestaF1": _respuesta1Controller.text,
        "RespuestaF2": _respuesta2Controller.text,
        "RespuestaF3": _respuesta3Controller.text,
      };

      setState(() {
        _preguntas.add(pregunta);
        // Limpiar campos después de agregar
        _preguntaController.clear();
        _respuestaVController.clear();
        _respuesta1Controller.clear();
        _respuesta2Controller.clear();
        _respuesta3Controller.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pregunta agregada correctamente")),
      );
    }
  }

  Map<String, dynamic>? getData() {
    return {'lispreheroe': _preguntas}; // si no pasa la validación
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isHorizontal = size.width > size.height;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Imágenes
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/avatars/heroes1.png",
                        height: isHorizontal ? 200 : 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "assets/avatars/heroes2.png",
                        height: isHorizontal ? 200 : 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Campo: Pregunta
                TextFormField(
                  controller: _preguntaController,
                  decoration: const InputDecoration(
                    labelText: "Pregunta",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.question_answer),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ingrese una palabra'
                      : value.length < 10
                      ? 'La pregunta debe tener al menos 10 caracteres'
                      : null,
                ),
                const SizedBox(height: 16),

                // Campo: Respuesta correcta
                TextFormField(
                  controller: _respuestaVController,
                  decoration: const InputDecoration(
                    labelText: "Respuesta Correcta",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_circle_outline),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Campo obligatorio"
                      : null,
                ),
                const SizedBox(height: 16),

                // Respuestas incorrectas
                TextFormField(
                  controller: _respuesta1Controller,
                  decoration: const InputDecoration(
                    labelText: "Respuesta Incorrecta 1",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.close),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Campo obligatorio"
                      : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _respuesta2Controller,
                  decoration: const InputDecoration(
                    labelText: "Respuesta Incorrecta 2",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.close),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Campo obligatorio"
                      : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _respuesta3Controller,
                  decoration: const InputDecoration(
                    labelText: "Respuesta Incorrecta 3",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.close),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Campo obligatorio"
                      : null,
                ),
                const SizedBox(height: 24),

                // Botones
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _agregarPregunta,
                        icon: const Icon(Icons.add),
                        label: const Text("Agregar Pregunta"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Lista de preguntas agregadas
                const Text(
                  "Preguntas agregadas:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 12),
                if (_preguntas.isEmpty)
                  const Text(
                    "No hay preguntas agregadas.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ..._preguntas.asMap().entries.map((entry) {
                  final index = entry.key;
                  final pregunta = entry.value;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Pregunta #${index + 1}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pregunta: ${pregunta["Pregunta"]}"),
                          Text("Respuesta Correcta: ${pregunta["RespuestaV"]}"),
                          Text(
                            "Respuesta Incorrecta 1: ${pregunta["RespuestaF1"]}",
                          ),
                          Text(
                            "Respuesta Incorrecta 2: ${pregunta["RespuestaF2"]}",
                          ),
                          Text(
                            "Respuesta Incorrecta 3: ${pregunta["RespuestaF3"]}",
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
