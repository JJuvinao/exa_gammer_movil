import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  final type = "Content-Type";
  final app = "application/json";
  final _storageService = Get.find<StorageService>();

  Future<void> logout() async {
    await _storageService.logout();
  }

  User get getuser => _storageService.displayUser;
  String get gettoken => _storageService.displayToken;

  Future<String> registerUser(
    String username,
    String password,
    String role,
    String email,
  ) async {
    Userfrom userfrom = Userfrom(
      username: username,
      password: password,
      rol: role,
      correo: email,
      img: "assets/imagen/fotoperfil.png",
    );
    final url = Uri.parse(
      'https://www.apiexagammer.somee.com/api/Usuarios/Registro',
    );
    try {
      final res = await http
          .post(
            url,
            headers: <String, String>{type: 'application/json; charset=UTF-8'},
            body: jsonEncode(userfrom.toJson()),
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode == 200) {
        return "ok";
      }
      if (res.statusCode == 409) {
        return "existe";
      }
      return "false";
    } catch (e) {
      print("ERROR DEL REGISTRO: ${e.toString()}");
      return "false";
    }
  }

  Future<String?> iniciarSesionYObtenerRol(
    String username,
    String password,
  ) async {
    Userdto userdto = Userdto(username: username, password: password);
    final url = Uri.parse('https://apiexagammer.somee.com/api/Login');
    try {
      final res = await http
          .post(url, headers: {type: app}, body: jsonEncode(userdto.toJson()))
          .timeout(const Duration(seconds: 15));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        User user = User.fromjson(data["user"]);
        String token = data["token"];
        await _storageService.login(user, token);
        return user.rol;
      }
      return null;
    } catch (e) {
      print("ERROR DEL LOGIN: ${e.toString()}");
      return null;
    }
  }

  Future<bool> unirseClase(String codigoClase) async {
    final url = Uri.parse(
      'https://www.apiexagammer.somee.com/api/Estudi_Clases/Ingresar',
    );
    try {
      final res = await http
          .post(
            url,
            headers: <String, String>{
              type: 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $gettoken',
            },
            body: jsonEncode(
              Userclase(userid: getuser.id, claseid: 0, codigo: codigoClase),
            ),
          )
          .timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      print("ERROR AL UNIRSE A LA CLASE");
    }
    return false;
  }

  Future<bool> actualizarUsuario(User usuario) async {
    const url = 'https://www.apiexagammer.somee.com/api/Usuarios/UpdateUser';

    try {
      final res = await http.put(
        Uri.parse(url),
        headers: {type: app, 'Authorization': 'Bearer $gettoken'},
        body: jsonEncode(usuario.toJson()),
      );

      if (res.statusCode == 200) {
        await _storageService.login(usuario, gettoken);
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(" Excepción al actualizar perfil: $e");
      return false;
    }
  }

  Future<bool> actualizarPremium(int userId, bool premium) async {
    const url = 'https://www.apiexagammer.somee.com/api/Usuarios/UpdatePremium';

    try {
      final res = await http.put(
        Uri.parse(url),
        headers: {type: app, 'Authorization': 'Bearer $gettoken'},
        body: jsonEncode({"id_user": userId, "premium": premium}),
      );

      if (res.statusCode == 200) {
        final userActualizado = getuser.copyWith(premium: premium);
        await _storageService.login(userActualizado, gettoken);
        update();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(" Excepción al actualizar premium: $e");
      return false;
    }
  }
}
