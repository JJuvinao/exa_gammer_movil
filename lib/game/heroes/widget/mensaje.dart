import 'package:exa_gammer_movil/ui/home/vista/examen/examen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void mostarmensaje({
  required String titulo,
  required String mensaje,
  required Function onConfirm,
}) {
  Get.defaultDialog(
    title: titulo,
    middleText: mensaje,
    confirm: ElevatedButton(
      onPressed: () {
        onConfirm();
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        Get.back(); // Cerrar el diálogo
        Get.off(
          () => ExamenView(vista: "Examen"),
        ); // Ejecutar acción del usuario
      },
      child: Text("Volver al examen"),
    ),
  );
}

dynamic calcularMensaje({
  required int vidapj,
  required int vidanpc,
  required bool vacia,
}) {
  if ((vidanpc <= 0 && vacia) || (vidanpc <= 0)) {
    return {"titulo": "¡Victoria! 🎉", "mensaje": "Has derrotado al enemigo"};
  }
  if (vidapj <= 0) {
    return {
      "titulo": "¡Derrota! 💀",
      "mensaje": "Tu personaje ha sido derrotado",
    };
  }
  if (vidanpc > 0 && vacia) {
    return {
      "titulo": "¡Fin del combate!",
      "mensaje": "Te quedan sin preguntas por responder",
    };
  }
}
