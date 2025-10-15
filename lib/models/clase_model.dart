class clase {
  final int id;
  final String nombre;
  final String tema;
  final String autor;
  final String codigo;
  final bool estado;
  final String fecha;
  final String img;
  final int id_profe;

  clase({
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

  factory clase.fromjson(Map<String, dynamic> json) {
    return clase(
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
