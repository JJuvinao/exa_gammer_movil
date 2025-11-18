import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/estudiante/detalle_clase_estu.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Detalle_Clase_Profesor/detalle_clase_profe.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/home_profesor.dart';
import 'package:exa_gammer_movil/ui/course/courseView.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/ui/detalle_examen.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/ui/info_examen.dart';
import 'package:exa_gammer_movil/ui/home/vista/perfil/profile_view.dart';
import 'package:exa_gammer_movil/ui/home/estudiante/home_estudiante.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/info_clase.dart';
import 'package:exa_gammer_movil/ui/home/vista/clase/estud_clase.dart';
import 'package:exa_gammer_movil/ui/home/vista/examen/ui/resultados.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VistaControles extends GetxController {
  var screens = <Widget>[].obs;
  var _navBarItems = <BottomNavigationBarItem>[].obs;
  final UserController user = Get.find<UserController>();

  List<Widget> getScreens(String vista) {
    screens.clear();
    if (vista == "Profesor") {
      screens.addAll([HomeProfesor(), courseScreen(), ProfileView()]);
    } else {
      screens.addAll([HomeEstudiante(), courseScreen(), ProfileView()]);
    }
    return screens;
  }

  List<Widget> getScreens_Clase(String vista) {
    screens.clear();
    if (vista == "Profesor") {
      screens.addAll([DetalleClase(), Info_Clase(), Estud_Clase()]);
    } else {
      screens.addAll([DetalleClase_Estu(), Info_Clase(), Estud_Clase()]);
    }
    return screens;
  }

  List<Widget> getScreens_Examen() {
    screens.clear();
    if (user.getuser.rol == "Profesor") {
      screens.addAll([DetalleExamenPage(), Info_Examen(), Resultados()]);
    } else {
      screens.addAll([DetalleExamenPage(), Info_Examen()]);
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
        if (user.getuser.rol == "Profesor") {
          _navBarItems.addAll(const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school_rounded),
              label: 'Detalle Clase',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: 'Info Clase',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'Estudiantes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Estadísticas',
            ),
          ]);
        } else {
          _navBarItems.addAll(const [
            BottomNavigationBarItem(
              icon: Icon(Icons.school_rounded),
              label: 'Detalle Clase',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_rounded),
              label: 'Info Clase',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_rounded),
              label: 'Estudiantes',
            ),
          ]);
        }

        return _navBarItems;
      case 'Examen':
        _navBarItems.clear();
        if (user.getuser.rol == "Profesor") {
          _navBarItems.addAll(const [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Detalle Examen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info Examen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grade),
              label: 'Calificaciones',
            ),
          ]);
        } else {
          _navBarItems.addAll(const [
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Detalle Examen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info Examen',
            ),
          ]);
        }

        return _navBarItems;
      default:
        _navBarItems.clear();
        break;
    }
    return _navBarItems;
  }
}
