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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF0f0f1e),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF00F0FF).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFF00F0FF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Color(0xFF00F0FF),
            unselectedItemColor: Colors.grey[600],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              shadows: [
                Shadow(
                  color: Color(0xFF00F0FF).withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(
              size: 28,
              shadows: [
                Shadow(
                  color: Color(0xFF00F0FF).withOpacity(0.8),
                  blurRadius: 15,
                ),
                Shadow(
                  color: Color(0xFF00FF41).withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            unselectedIconTheme: IconThemeData(
              size: 24,
            ),
            items: _navBarItems.map((item) {
              final isSelected = _navBarItems.indexOf(item) == _currentIndex;
              return BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              Color(0xFF00F0FF).withOpacity(0.2),
                              Color(0xFF00FF41).withOpacity(0.2),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(
                            color: Color(0xFF00F0FF).withOpacity(0.5),
                            width: 1.5,
                          )
                        : null,
                  ),
                  child: item.icon,
                ),
                activeIcon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00F0FF).withOpacity(0.3),
                        Color(0xFF00FF41).withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xFF00F0FF),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF00F0FF).withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: item.activeIcon ?? item.icon,
                ),
                label: item.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}