class User {
  final int id;
  final String username;
  final String rol;
  final String email;
  final String? img;
  final bool? premium;

  User({
    required this.id,
    required this.username,
    required this.rol,
    required this.email,
    this.img,
    this.premium,
  });

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["nombre"],
      rol: json["rol"],
      email: json["correo"],
      img: json["imagen"],
      premium: json["premium"],
    );
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
  final String username;
  final String password;
  final String rol;
  final String correo;
  final String img;

  Userfrom({
    required this.username,
    required this.password,
    required this.rol,
    required this.correo,
    required this.img,
  });

  Map<String, dynamic> toJson() {
    return {
      'Nombre': username,
      'Contrasena': password,
      'Rol': rol,
      'Correo': correo,
      'Imagen': img,
    };
  }
}

class Userto {
  final int id;
  final String username;
  final String email;
  final String? img;

  Userto({
    required this.id,
    required this.username,
    required this.email,
    this.img,
  });

  factory Userto.fromjson(Map<String, dynamic> json) {
    return Userto(
      id: json["id"],
      username: json["nombre"],
      email: json["correo"],
      img: json["imagen"],
    );
  }
}

class Userclase {
  final int userid;
  final int claseid;
  final String codigo;

  Userclase({
    required this.userid,
    required this.claseid,
    required this.codigo,
  });

  Map<String, dynamic> toJson() {
    return {'Id_Usuario': userid, 'Id_Clase': claseid, 'Codigo': codigo};
  }
}
