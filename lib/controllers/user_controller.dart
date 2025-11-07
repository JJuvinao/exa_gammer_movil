import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  final _storageService = Get.find<StorageService>();

  Future<void> logout() async {
    await _storageService.logout();
  }

  User get getuser => _storageService.displayUser;
  String get gettoken => _storageService.displayToken;

  Future<bool> registerUser(
    String username,
    String password,
    String role,
    String email,
  ) async {
    Userfrom _userfrom = Userfrom(
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
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(_userfrom.toJson()),
          )
          .timeout(Duration(seconds: 15));

      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("ERROR DEL REGISTRO: ${e.toString()}");
      return false;
    }
  }

  Future<String?> iniciarSesionYObtenerRol(
    String username,
    String password,
  ) async {
    Userdto _userdto = Userdto(username: username, password: password);
    final url = Uri.parse('https://apiexagammer.somee.com/api/Login');
    try {
      final res = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(_userdto.toJson()),
          )
          .timeout(Duration(seconds: 15));
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

  Future<bool> UnirseClase(String codigoClase) async {
    final url = Uri.parse(
      'https://www.apiexagammer.somee.com/api/Estudi_Clases/Ingresar',
    );
    try {
      final res = await http
          .post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer ${gettoken}',
            },
            body: jsonEncode(
              new Userclase(
                userid: getuser.id,
                claseid: 0,
                codigo: codigoClase,
              ),
            ),
          )
          .timeout(Duration(seconds: 15));
      if (res.statusCode != 200) {
        return false;
      }
      return true;
    } catch (e) {
      print("ERROR AL UNIRSE A LA CLASE");
    }
    return false;
  }
}
