import 'package:exa_gammer_movil/ui/home/widget/boton_comenzar.dart';
import 'package:exa_gammer_movil/ui/home/widget/fondo_home.dart';
import 'package:exa_gammer_movil/ui/home/widget/logo_glow.dart';
import 'package:exa_gammer_movil/ui/home/widget/titulo_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          const FondoHome(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: screenHeight * 0.05),
                          const TituloHome(),
                          SizedBox(height: screenHeight * 0.06),
                          LogoGlow(
                            size: screenWidth * 0.45,
                            padding: screenWidth * 0.08,
                          ),
                          SizedBox(height: screenHeight * 0.08),
                          BotonComenzar(
                            width: screenWidth * 0.75,
                            height: screenHeight * 0.065,
                            onTap: () => Get.to(() => Vistalogin()),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}