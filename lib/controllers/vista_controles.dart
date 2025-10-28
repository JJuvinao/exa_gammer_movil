import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/profesor/detalle_clase.dart';
import 'package:exa_gammer_movil/ui/home/profesor/home_profesor.dart';
import 'package:exa_gammer_movil/ui/course/courseView.dart';
import 'package:exa_gammer_movil/ui/home/vista/perfil/profile_view.dart';
import 'package:exa_gammer_movil/ui/home/estudiante/home_estudiante.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/info_clase.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/estud_clase.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class VistaControles extends GetxController {
  var screens = <Widget>[].obs;
  var _navBarItems = <BottomNavigationBarItem>[].obs;
  final UserController user = Get.find<UserController>();

  List<Widget> getScreens(String vista) {
    switch (vista) {
      case 'Estudiante':
        screens.clear();
        screens.addAll([HomeEstudiante(), courseScreen(), ProfileView()]);
        return screens;
      case 'Profesor':
        screens.clear();
        screens.addAll([HomeProfesor(), courseScreen(), ProfileView()]);
        return screens;
      case 'Clase':
        screens.clear();
        screens.addAll([
          DetalleClase(),
          MainView(vista: user.getuser.rol),
          Info_Clase(),
          Estud_Clase(),
        ]);
        return screens;
      default:
        screens.clear();
        break;
    }
    return screens;
  }

  List<Widget> getScreens_Clase(String vista) {
    switch (vista) {
      case 'Clase':
        screens.clear();
        screens.addAll([
          DetalleClase(),
          DetalleClase(),
          Info_Clase(),
          Estud_Clase(),
        ]);
        return screens;
      default:
        screens.clear();
        break;
    }
    return screens;
  }

  List<BottomNavigationBarItem> navBarItems(String vista) {
    switch (vista) {
      case 'Estudiante':
        _navBarItems.clear();
        _navBarItems.addAll(const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Cursos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ]);
        return _navBarItems;
      case 'Profesor':
        _navBarItems.clear();
        _navBarItems.addAll(const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Cursos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ]);
        return _navBarItems;
      case 'Clase':
        _navBarItems.clear();
        _navBarItems.addAll(const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Detalle Clase',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info Clase'),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Estudiantes',
          ),
        ]);
        return _navBarItems;
      default:
        _navBarItems.clear();
        break;
    }
    return _navBarItems;
  }
}
