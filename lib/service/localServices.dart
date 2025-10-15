import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:exa_gammer_movil/models/user_model.dart';

class StorageService extends GetxService {
  final _box = GetStorage();
  final String _isLoggedInKey = 'isLoggedIn';
  final String _userKey = 'username';
  final String _tokenKey = 'token';

  final user = User(id: 0, username: '', rol: '', email: '', img: '').obs;
  final token = ''.obs;

  User get displayUser => user.value;
  String get displayToken => token.value;

  Future<StorageService> init() async {
    user.value =
        _box.read<User>(_userKey) ??
        User(id: 0, username: '', rol: '', email: '', img: '');
    token.value = _box.read<String>(_tokenKey) ?? '';
    return this;
  }

  Future<void> login(User newUsername, String newToken) async {
    user.value = newUsername;
    token.value = newToken;

    await _box.write(_userKey, newUsername);
    await _box.write(_tokenKey, newToken);
    await _box.write(_isLoggedInKey, true);
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
