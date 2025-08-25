class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class Userdto {
  final String username;
  final String password;

  Userdto({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}

class Userfrom {
  final int id;
  final String username;
  final String rol;
  final String correo;
  final String fotoUrl;

  Userfrom({
    required this.id,
    required this.username,
    required this.rol,
    required this.correo,
    required this.fotoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'rol': rol,
      'correo': correo,
      'fotoUrl': fotoUrl,
    };
  }

  factory Userfrom.fromJson(Map<String, dynamic> json) {
    return Userfrom(
      id: json['id'],
      username: json['nombre'],
      rol: json['rol'],
      correo: json['correo'],
      fotoUrl: json['imagen'],
    );
  }
}
