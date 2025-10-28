import 'package:exa_gammer_movil/controllers/vista_controles.dart';
import 'package:exa_gammer_movil/ui/home/profesor/main_view.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaseView extends StatefulWidget {
  final String vista;
  const ClaseView({super.key, required this.vista});
  @override
  State<ClaseView> createState() => _ClaseViewState();
}

class _ClaseViewState extends State<ClaseView> {
  int _currentIndex = 0;
  final UserController user = Get.find<UserController>();

  List<BottomNavigationBarItem> get _navBarItems =>
      Get.find<VistaControles>().navBarItems(widget.vista);

  List<Widget> get _screens =>
      Get.find<VistaControles>().getScreens_Clase(widget.vista);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => MainView(vista: user.getuser.rol));
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}
