import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/add_user.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/login.dart';

class Vistalogin extends StatefulWidget {
  @override
  _VistaloginState createState() => _VistaloginState();
}

class _VistaloginState extends State<Vistalogin> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo gamer
          Image.asset('assets/imagen/logo_exa.png', fit: BoxFit.cover),
          // Capa de opacidad
          Container(color: Colors.black.withOpacity(0.5)),
          // Contenido principal
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Center(
                    child: Column(
                      children: [
                        // Logo y textos
                        SizedBox(height: 12),
                        Text(
                          'EXA-GAMMER',
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'Tu plataforma educativa gamificada',
                          style: TextStyle(
                            fontFamily: "poppins",
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTab(
                                    Icons.login,
                                    'Iniciar sesión',
                                    0,
                                  ),
                                ),
                                Expanded(
                                  child: _buildTab(
                                    Icons.person_add,
                                    'Registrarse',
                                    1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: selectedTabIndex == 1
                                  ? AgregarUsuario()
                                  : LoginForm(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(IconData icon, String label, int index) {
    final isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTabIndex = index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.indigo : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.indigo : Colors.grey),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontFamily: "poppins",
                fontSize: 16,
                color: isSelected ? Colors.indigo : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
