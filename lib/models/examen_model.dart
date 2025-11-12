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
  final String palabra;
  final String pista;

  Ahorcado({required this.palabra, required this.pista});

  factory Ahorcado.fromjson(Map<String, dynamic> json) {
    return Ahorcado(palabra: json["palabra"], pista: json["pista"]);
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

class Resultados {
  final int id;
  final int id_Estudiane;
  final int id_Examen;
  final int intentos;
  final int aciertos;
  final int fallos;
  final double? nota;
  final String? recomendacion;

  Resultados({
    required this.id,
    required this.id_Estudiane,
    required this.id_Examen,
    required this.intentos,
    required this.aciertos,
    required this.fallos,
    this.nota,
    this.recomendacion,
  });

  factory Resultados.fromjson(Map<String, dynamic> json) {
    return Resultados(
      id: json["id"],
      id_Estudiane: json["id_Estudiane"],
      id_Examen: json["id_Examen"],
      intentos: json["intentos"],
      aciertos: json["aciertos"],
      fallos: json["fallos"],
      nota: (json['nota'] as num?)?.toDouble(),
      recomendacion: json["recomendacion"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Id_Estudiane': id_Estudiane,
      'Id_Examen': id_Examen,
      'Intentos': intentos,
      'Aciertos': aciertos,
      'Fallos': fallos,
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
  final int intentos;
  final int aciertos;
  final int fallos;
  final double? nota;
  final String? recomendacion;

  Estudi_Resultados({
    required this.id,
    required this.id_Estudiante,
    required this.Nombre,
    required this.correo,
    required this.img,
    required this.id_Examen,
    required this.intentos,
    required this.aciertos,
    required this.fallos,
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
