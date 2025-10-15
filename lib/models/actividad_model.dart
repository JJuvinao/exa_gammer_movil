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
