import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:exa_gammer_movil/models/clase_model.dart';
import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:exa_gammer_movil/service/localServices.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';

class ClaseController extends GetxController {
  var claseList = <Clase>[].obs;
  var searchQuery = ''.obs;
  final _storageService = Get.find<StorageService>();

  Clase get getclase => _storageService.displayClase;

  Future<void> saveClase(Clase newClase) async {
    await _storageService.saveClase(newClase);
  }

  Future<void> logoutClase() async {
    await _storageService.logoutClase();
  }

  void ClearClase() {
    claseList.clear();
  }

  // ==================== AGREGAR CLASE ==================== //
  Future<bool> AddClase(Clasedto newclase, String token) async {
    final url = Uri.parse(
      'https://www.apiexagammer.somee.com/api/Clases/ClasePost',
    );

    try {
      final res = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(newclase.toJson()),
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR AL AGREGAR CLASE: ${e.toString()}");
      return false;
    }
  }

  // ==================== FILTRAR LISTA ==================== //
  Future<List<Clase>> filteredList(int id, String token, String rol) async {
    if (rol == 'Profesor') {
      await CargarClases(id, token);
    } else {
      await CargarClases_Estudiante(id, token);
    }

    if (claseList.isEmpty) return [];

    if (searchQuery.value.isEmpty) {
      return claseList;
    } else {
      return claseList
          .where(
            (clase) => clase.nombre.toLowerCase().contains(
              searchQuery.value.toLowerCase(),
            ),
          )
          .toList();
    }
  }

  // ==================== CARGAR CLASES PROFESOR ==================== //
  Future<void> CargarClases(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Clases/Profe_Clases/$id',
      );

      final res = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode != 200) {
        print(res.statusCode);
      }

      final data = jsonDecode(res.body);
      List<Clase> _claseList = [];

      for (var item in data) {
        _claseList.add(Clase.fromjson(item));
      }

      claseList.value = _claseList;
    } catch (e) {
      print("ERROR DE LA CARGA DE CLASES ${e.toString()}");
    }
  }

  // ==================== CARGAR CLASES ESTUDIANTE ==================== //
  Future<void> CargarClases_Estudiante(int id, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Estudi_Clases/$id',
      );

      final res = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode != 200) {
        print(res.statusCode);
      }

      final data = jsonDecode(res.body);
      List<Clase> _claseList = [];

      for (var item in data) {
        _claseList.add(Clase.fromjson(item));
      }

      claseList.value = _claseList;
    } catch (e) {
      print("ERROR DE LA CARGA DE CLASES ${e.toString()}");
    }
  }

  // ==================== CARGAR USUARIOS DE CLASE ==================== //
  Future<List<User>> CargarUser_Clase(int id_clase, String token) async {
    try {
      final url = Uri.parse(
        'https://apiexagammer.somee.com/api/Estudi_Clases/usersclase/$id_clase',
      );

      final res = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode != 200) {
        print(res.statusCode);
        return [];
      }

      final data = jsonDecode(res.body);
      List<User> _userList = [];

      for (var item in data) {
        _userList.add(User.fromjson(item));
      }

      return _userList;
    } catch (e) {
      print("ERROR DE LA CARGA LOS ESTUDIANTES DE LA CLASES ${e.toString()}");
    }
    return [];
  }

  Future<bool> DeleteClase(int id_clase, String token) async {
    try {
      final url = Uri.parse(
        'https://www.apiexagammer.somee.com/api/Clases/$id_clase',
      );

      final res = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(res.statusCode);
      if (res.statusCode != 204 && res.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      print("ERROR AL ELIMINAR LA CLASE ${e.toString()}");
    }
    return false;
  }

  // ==================== CONTROLADORES Y ESTADO ==================== //
  final txtNombre = TextEditingController();
  final txtTema = TextEditingController();
  final txtAutor = TextEditingController();

  final isLoading = false.obs;
  final mostrarAvatar = false.obs;
  final avatarSeleccionado = RxnString();

  final avatarList = [
    "assets/fondo/cieloatardecer.jpg",
    "assets/fondo/cieloazul.jpg",
    "assets/fondo/cielomorado.jpg",
    "assets/fondo/cielonoche.jpg",
    "assets/fondo/fondo1.jpg",
  ];

  // ==================== CREAR CLASE ==================== //
  Future<void> crearClase(user, token, GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    if (avatarSeleccionado.value == null) {
      _mostrarSnackbar(
        'Imagen requerida',
        'Por favor selecciona una imagen para la clase',
        Colors.orange[700]!,
      );
      return;
    }

    isLoading.value = true;

    try {
      final nuevaClase = Clasedto(
        nombre: txtNombre.text,
        tema: txtTema.text,
        autor: txtAutor.text,
        imagenClase: avatarSeleccionado.value!,
        id_Profe: user.id,
      );

      final resultado = await AddClase(nuevaClase, token);

      if (resultado == true) {
        _mostrarSnackbar(
          '¡Éxito!',
          'La clase se creó correctamente',
          Colors.green[600]!,
        );

        limpiarFormulario();
        await Future.delayed(const Duration(milliseconds: 500));
        Get.off(() => MainView(vista: "Profesor"));
      } else {
        throw Exception();
      }
    } catch (_) {
      _mostrarSnackbar(
        'Error',
        'No se pudo crear la clase. Inténtalo de nuevo',
        Colors.red[600]!,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ==================== LIMPIAR FORMULARIO ==================== //
  void limpiarFormulario() {
    txtNombre.clear();
    txtTema.clear();
    txtAutor.clear();
    avatarSeleccionado.value = null;
    mostrarAvatar.value = false;
  }

  void seleccionarAvatar(String avatar) {
    avatarSeleccionado.value = avatar;
    mostrarAvatar.value = true;
  }

  void _mostrarSnackbar(String titulo, String mensaje, Color color) {
    Get.snackbar(
      titulo,
      mensaje,
      backgroundColor: color,
      colorText: Colors.white,
      icon: const Icon(Icons.info, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void updateClase(
    int index,
    String newNombre,
    String newTema,
    String newAutor,
  ) {}

  void deleteClase(int index) {
    claseList.removeAt(index);
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  @override
  void onClose() {
    txtNombre.dispose();
    txtTema.dispose();
    txtAutor.dispose();
    super.onClose();
  }
}
