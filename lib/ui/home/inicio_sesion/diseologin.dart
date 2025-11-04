import 'package:exa_gammer_movil/ui/home/inicio_sesion/Widgets_Inicio_Sesion/custom_tab.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/Widgets_Inicio_Sesion/fondo_login.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/Widgets_Inicio_Sesion/glass_card.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/Widgets_Inicio_Sesion/logo_header.dart';
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
          const FondoLogin(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const LogoHeader(),
                  const SizedBox(height: 40),
                  GlassCard(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTab(
                                icon: Icons.login_rounded,
                                label: 'Iniciar sesión',
                                isSelected: selectedTabIndex == 0,
                                onTap: () => setState(() => selectedTabIndex = 0),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomTab(
                                icon: Icons.person_add_rounded,
                                label: 'Registrarse',
                                isSelected: selectedTabIndex == 1,
                                onTap: () => setState(() => selectedTabIndex = 1),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.1, 0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: selectedTabIndex == 1
                              ? AgregarUsuario()
                              : LoginForm(),
                        ),
                      ],
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
}