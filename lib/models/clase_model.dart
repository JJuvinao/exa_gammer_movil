class Clase {
  final int id;
  final String nombre;
  final String tema;
  final String autor;
  final String codigo;
  final bool estado;
  final String fecha;
  final String img;
  final int id_profe;

  Clase({
    required this.id,
    required this.nombre,
    required this.tema,
    required this.autor,
    required this.codigo,
    required this.estado,
    required this.fecha,
    required this.img,
    required this.id_profe,
  });

  factory Clase.fromjson(Map<String, dynamic> json) {
    return Clase(
      id: json["id_Clase"],
      nombre: json["nombre"],
      tema: json["tema"],
      autor: json["autor"],
      codigo: json["codigo"],
      estado: json["estado"],
      fecha: json["fechaCreacion"],
      img: json["imagenClase"],
      id_profe: json["id_Profe"],
    );
  }
}

class Clasedto {
  final String nombre;
  final String tema;
  final String autor;
  final String imagenClase;
  final int id_Profe;

  Clasedto({
    required this.nombre,
    required this.tema,
    required this.autor,
    required this.imagenClase,
    required this.id_Profe,
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "tema": tema,
      "autor": autor,
      "imagenClase": imagenClase,
      "id_Profe": id_Profe,
    };
  }
}
