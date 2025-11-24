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

  late final List<BottomNavigationBarItem> _navBarItems;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    /// Guardamos los valores una sola vez para evitar reconstrucciones peligrosas
    final controller = Get.find<VistaControles>();
    _navBarItems = controller.navBarItems(widget.vista);
    _screens = controller.getScreens_Examen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      backgroundColor: const Color(0xFF0a0a14),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1a1a2e), Color(0xFF0f0f1e)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00F0FF).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color(0xFF00F0FF).withOpacity(0.3),
                width: 1.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: const Color(0xFF00F0FF),
            unselectedItemColor: Colors.grey[600],
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,

            // 👉 Sin async ni delays (para evitar lifecycle errors)
            onTap: (index) {
              if (!mounted) return;
              setState(() {
                _currentIndex = index;
              });
            },

            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              shadows: [
                Shadow(
                  color: const Color(0xFF00F0FF).withOpacity(0.5),
                  blurRadius: 8,
                ),
              ],
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),

            selectedIconTheme: IconThemeData(
              size: 28,
              shadows: [
                Shadow(
                  color: const Color(0xFF00F0FF).withOpacity(0.8),
                  blurRadius: 15,
                ),
                Shadow(
                  color: const Color(0xFF00FF41).withOpacity(0.4),
                  blurRadius: 20,
                ),
              ],
            ),
            unselectedIconTheme: const IconThemeData(size: 24),

            items: _navBarItems.map((item) {
              final isSelected = _navBarItems.indexOf(item) == _currentIndex;

              return BottomNavigationBarItem(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              const Color(0xFF00F0FF).withOpacity(0.2),
                              const Color(0xFF00FF41).withOpacity(0.2),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(
                            color: const Color(0xFF00F0FF).withOpacity(0.5),
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
                        const Color(0xFF00F0FF).withOpacity(0.3),
                        const Color(0xFF00FF41).withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF00F0FF),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00F0FF).withOpacity(0.4),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: item.activeIcon,
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
