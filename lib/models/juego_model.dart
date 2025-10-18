class Juego {
  final int id;
  final String nombre;
  final String tipo;

  Juego({required this.id, required this.nombre, required this.tipo});

  factory Juego.fromJson(Map<String, dynamic> json) {
    return Juego(
      id: json['id_Juego'],
      nombre: json['nombre'],
      tipo: json['tipo'],
    );
  }
}
