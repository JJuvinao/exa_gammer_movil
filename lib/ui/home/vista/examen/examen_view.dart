import 'package:exa_gammer_movil/controllers/vista_controles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamenView extends StatefulWidget {
  final String vista;
  const ExamenView({super.key, required this.vista});
  @override
  State<ExamenView> createState() => _ExamenViewState();
}

class _ExamenViewState extends State<ExamenView> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> get _navBarItems =>
      Get.find<VistaControles>().navBarItems(widget.vista);

  List<Widget> get _screens => Get.find<VistaControles>().getScreens_Examen();

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
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navBarItems,
      ),
    );
  }
}
