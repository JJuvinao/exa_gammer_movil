import 'package:exa_gammer_movil/controllers/vista_controles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  final String vista;
  const MainView({super.key, required this.vista});
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> get _navBarItems =>
      Get.find<VistaControles>().navBarItems(widget.vista);

  List<Widget> get _screens =>
      Get.find<VistaControles>().getScreens(widget.vista);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
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
