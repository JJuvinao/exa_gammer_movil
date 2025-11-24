import 'dart:convert';

class Examen {
  final int id;
  final String nombre;
  final String tema;
  final String autor;
  final String descripcion;
  final String codigo;
  final String fecha;
  final String img;
  final int id_juego;

  Examen({
    required this.id,
    required this.nombre,
    required this.tema,
    required this.autor,
    required this.descripcion,
    required this.codigo,
    required this.fecha,
    required this.img,
    required this.id_juego,
  });

  factory Examen.fromjson(Map<String, dynamic> json) {
    return Examen(
      id: json["id_Examen"],
      nombre: json["nombre"],
      tema: json["tema"],
      autor: json["autor"],
      descripcion: json["descripcion"],
      codigo: json["codigo"],
      fecha: json["fechaCreacion"],
      img: json["imagenExamen"],
      id_juego: json["id_Juego"],
    );
  }
}

class Ahorcado {
  final int id;
  final String palabra;
  final String pista;
  final String codigo_exa;

  Ahorcado({
    required this.id,
    required this.palabra,
    required this.pista,
    required this.codigo_exa,
  });

  factory Ahorcado.fromjson(Map<String, dynamic> json) {
    return Ahorcado(
      id: json["id"],
      palabra: json["palabra"],
      pista: json["pista"],
      codigo_exa: json["codigo_Exa"],
    );
  }
}

class Heroes {
  final int id;
  final String pregunta;
  final String respuesta;
  final String respuestaf1;
  final String respuestaf2;
  final String respuestaf3;
  final String codigo_exa;

  Heroes({
    required this.id,
    required this.pregunta,
    required this.respuesta,
    required this.respuestaf1,
    required this.respuestaf2,
    required this.respuestaf3,
    required this.codigo_exa,
  });

  factory Heroes.fromjson(Map<String, dynamic> json) {
    return Heroes(
      id: json["id"],
      pregunta: json["pregunta"],
      respuesta: json["respuestaV"],
      respuestaf1: json["respuestaF1"],
      respuestaf2: json["respuestaF2"],
      respuestaf3: json["respuestaF3"],
      codigo_exa: json["codigo_Exa"],
    );
  }
}

class Respuestas_Heroes {
  final int id_pregunta;
  final String respuesta;
  Respuestas_Heroes({required this.id_pregunta, required this.respuesta});
  Map<String, dynamic> toJson() {
    return {'Id_Pregunta': id_pregunta, 'Respuesta': respuesta};
  }

  factory Respuestas_Heroes.fromjson(Map<String, dynamic> json) {
    return Respuestas_Heroes(
      id_pregunta: json["Id_Pregunta"],
      respuesta: json["Respuesta"],
    );
  }
}

class Preguntas_Respuestas {
  final String pregunta;
  final String respuestaV;
  final String respuesta;

  Preguntas_Respuestas({
    required this.pregunta,
    required this.respuestaV,
    required this.respuesta,
  });
}

class Resultado_Ahorcado {
  final String palabra;
  final String pista;
  final int intentos;
  final int fallos;
  final int aciertos;
  final bool acerto;

  Resultado_Ahorcado({
    required this.palabra,
    required this.pista,
    required this.intentos,
    required this.fallos,
    required this.aciertos,
    required this.acerto,
  });
}

class Respuestas_Ahorcado {
  final int id_palabra;
  final int intentos;
  final int fallos;
  final int aciertos;
  final bool acerto;

  Respuestas_Ahorcado({
    required this.id_palabra,
    required this.intentos,
    required this.fallos,
    required this.aciertos,
    required this.acerto,
  });
  Map<String, dynamic> toJson() {
    return {
      'Id_Palabra': id_palabra,
      'Intentos': intentos,
      'Fallos': fallos,
      'Aciertos': aciertos,
      'Acerto': acerto,
    };
  }

  factory Respuestas_Ahorcado.fromjson(Map<String, dynamic> json) {
    return Respuestas_Ahorcado(
      id_palabra: json["Id_Palabra"],
      intentos: json["Intentos"],
      fallos: json["Fallos"],
      aciertos: json["Aciertos"],
      acerto: json["Acerto"],
    );
  }
}

class Resultados {
  final int id;
  final int id_Estudiane;
  final int id_Examen;
  final List<dynamic> resultados;
  final double? nota;
  final String? recomendacion;

  Resultados({
    required this.id,
    required this.id_Estudiane,
    required this.id_Examen,
    required this.resultados,
    this.nota,
    this.recomendacion,
  });

  factory Resultados.fromjson(Map<String, dynamic> json) {
    return Resultados(
      id: json["id"],
      id_Estudiane: json["id_Estudiane"],
      id_Examen: json["id_Examen"],
      resultados: jsonDecode(json["resultado"]),
      nota: (json['nota'] as num?)?.toDouble(),
      recomendacion: json["recomendacion"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Id_Estudiane': id_Estudiane,
      'Id_Examen': id_Examen,
      'Resultados': resultados,
      'Nota': nota,
      'Recomendacion': recomendacion,
    };
  }
}

class Estudi_Resultados {
  final int id;
  final int id_Estudiante;
  final String Nombre;
  final String correo;
  final String img;
  final int id_Examen;
  final List<dynamic> resultados;
  final double? nota;
  final String? recomendacion;

  Estudi_Resultados({
    required this.id,
    required this.id_Estudiante,
    required this.Nombre,
    required this.correo,
    required this.img,
    required this.id_Examen,
    required this.resultados,
    this.nota,
    this.recomendacion,
  });
}

class Calificar {
  final int id_estu_exa;
  final int id_estu;
  final double nota;
  final String reco;

  Calificar({
    required this.id_estu_exa,
    required this.id_estu,
    required this.nota,
    required this.reco,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id_estu_exa': id_estu_exa,
      'Id_estu': id_estu,
      'Nota': nota,
      'Recomendacion': reco,
    };
  }
}
