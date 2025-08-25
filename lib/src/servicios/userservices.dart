import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:exa_gammer_movil/src/objetos/usuario.dart';

class UserService {
  // URL de tu endpoint en la API que recibe el objeto Usuario completo
  final String _apiBaseUrl =
      "https://192.168.0.6/api/Usuarios"; // Ejemplo: POST /api/usuarios

  /// Permite al usuario seleccionar una imagen de la galería.
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  /// Convierte un XFile (imagen) a una cadena Base64.
  Future<String?> imageToBase64(XFile? imageFile) async {
    if (imageFile == null) {
      return null;
    }
    // Lee los bytes del archivo
    Uint8List imageBytes = await imageFile.readAsBytes();
    // Codifica los bytes a Base64
    String base64String = base64Encode(imageBytes);
    // Opcional: Puedes añadir el prefijo de tipo de dato si tu API lo espera
    // Por ejemplo: "data:image/jpeg;base64,..."
    // String mimeType = lookupMimeType(imageFile.path) ?? 'application/octet-stream';
    // return 'data:$mimeType;base64,$base64String';
    return base64String;
  }

  /// Crea o actualiza un usuario enviando el objeto Usuario completo (con la imagen en Base64).
  ///
  /// [user] El objeto Usuario con todos sus datos, incluyendo la imagen en Base64 en fotoUrl.
  Future<bool> createOrUpdateUser(Userfrom user) async {
    // 1. Convertir el objeto Usuario a una cadena JSON
    final String requestBody = jsonEncode(user.toJson());

    try {
      // 2. Enviar la solicitud HTTP POST/PUT
      // Usamos http.post o http.put para enviar JSON
      final response = await http.post(
        Uri.parse(_apiBaseUrl), // O _apiBaseUrl + '/${user.id}' para PUT
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestBody,
      );

      // 3. Escuchar la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Operación exitosa: ${response.body}");
        return true;
      } else {
        print("Error al operar con el usuario. Código: ${response.statusCode}");
        print("Respuesta: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Ocurrió una excepción: $e");
      return false;
    }
  }

  Future<respuesta> checkUsernameExists(String username) async {
    respuesta res;

    if (username.isEmpty) {
      return respuesta(
        exists: false,
        message: 'Un nombre de usuario vacío no puede existir',
      );
    }

    final Uri url = Uri.parse('$_apiBaseUrl/getname/$username');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        res = respuesta(exists: false, message: 'Existe ya el usuario ');
        return res;
      } else {
        res = respuesta(exists: false, message: 'No existe el usuario');
        return res; // O podrías lanzar una excepción
      }
    } catch (e) {
      res = respuesta(exists: false, message: 'Error de red');
      return res; // En caso de error de red, asumimos que no existe
    }
  }

  Future<Map<String, dynamic>> login(Userdto user) async {
    final url = Uri.parse('https://localhost:7248/api/Login');

    final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
      print(jsonResponse['user']);
      final String token = jsonResponse['token'];
      final Userfrom user = Userfrom.fromJson(jsonResponse['user']);
      print(user.toJson());

      return {'token': token, 'user': user};
    } else if (res.statusCode == 401) {
      throw Exception(res.body);
    } else {
      throw Exception('Fallo la petición de login');
    }
  }
}

class respuesta {
  bool exists;
  String message;

  respuesta({required this.exists, required this.message});

  factory respuesta.fromJson(Map<String, dynamic> json) {
    return respuesta(
      exists: json['exists'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
