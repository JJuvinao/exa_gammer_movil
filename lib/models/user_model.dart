class User {
  final int id;
  final String username;
  final String rol;
  final String email;
  final String img;

  User({
    required this.id,
    required this.username,
    required this.rol,
    required this.email,
    required this.img,
  });

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["nombre"],
      rol: json["rol"],
      email: json["correo"],
      img: json["imagen"],
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
