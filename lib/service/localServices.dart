import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:exa_gammer_movil/models/examen_model.dart';

class StorageService extends GetxService {
  final _box = GetStorage();
  final String _isLoggedInKey = 'isLoggedIn';
  final String _userKey = 'username';
  final String _tokenKey = 'token';
  final String _claseKey = 'clase';
  final String _examenKey = 'examen';

  final user = User(id: 0, username: '', rol: '', email: '', img: '').obs;
  final token = ''.obs;
  final clase = Clase(
    id: 0,
    nombre: '',
    tema: '',
    autor: '',
    codigo: '',
    estado: false,
    fecha: '',
    img: '',
    id_profe: 0,
  ).obs;
  final examen = Examen(
    id: 0,
    nombre: '',
    tema: '',
    autor: '',
    descripcion: '',
    codigo: '',
    fecha: '',
    img: '',
    id_juego: 0,
  ).obs;

  User get displayUser => user.value;
  String get displayToken => token.value;
  Clase get displayClase => clase.value;
  Examen get displayExamen => examen.value;

  Future<StorageService> init() async {
    user.value =
        _box.read<User>(_userKey) ??
        User(id: 0, username: '', rol: '', email: '', img: '');
    token.value = _box.read<String>(_tokenKey) ?? '';
    clase.value =
        _box.read<Clase>(_claseKey) ??
        Clase(
          id: 0,
          nombre: '',
          tema: '',
          autor: '',
          codigo: '',
          estado: false,
          fecha: '',
          img: '',
          id_profe: 0,
        );
    examen.value =
        _box.read<Examen>(_examenKey) ??
        Examen(
          id: 0,
          nombre: '',
          tema: '',
          autor: '',
          descripcion: '',
          codigo: '',
          fecha: '',
          img: '',
          id_juego: 0,
        );
    return this;
  }

  Future<void> login(User newUsername, String newToken) async {
    user.value = newUsername;
    token.value = newToken;

    await _box.write(_userKey, newUsername);
    await _box.write(_tokenKey, newToken);
    await _box.write(_isLoggedInKey, true);
  }

  Future<void> saveClase(Clase newClase) async {
    clase.value = newClase;
    await _box.write(_claseKey, newClase);
  }

  Future<void> saveExamen(Examen newExamen) async {
    examen.value = newExamen;
    await _box.write(_examenKey, newExamen);
  }

  Future<void> logoutClase() async {
    await _box.remove(_claseKey);
    clase.value = Clase(
      id: 0,
      nombre: '',
      tema: '',
      autor: '',
      codigo: '',
      estado: false,
      fecha: '',
      img: '',
      id_profe: 0,
    );
  }

  Future<void> logoutExamen() async {
    await _box.remove(_examenKey);
    examen.value = Examen(
      id: 0,
      nombre: '',
      tema: '',
      autor: '',
      descripcion: '',
      codigo: '',
      fecha: '',
      img: '',
      id_juego: 0,
    );
  }

  bool get isLoggedIn => _box.read<bool>(_isLoggedInKey) ?? false;

  Future<void> logout() async {
    await _box.remove(_isLoggedInKey);
    await _box.remove(_userKey);
    await _box.remove(_tokenKey);

    token.value = '';
    user.value = User(id: 0, username: '', rol: '', email: '', img: '');
  }
}
