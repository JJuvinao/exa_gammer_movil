import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/widget/Plan_card.dart';
import 'package:exa_gammer_movil/ui/home/vista/perfil/Pago_premium.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14),
      appBar: AppBar(
        title: const Text(
          'Planes Premium',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Color(0xFF00F0FF),
            fontSize: 22,
            shadows: [Shadow(color: Colors.cyan, blurRadius: 8)],
          ),
        ),
        backgroundColor: const Color(0xFF16213e),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 16),

            PlanCard(
              title: 'Prueba Gratis (7 días)',
              features: [
                'Crea hasta 5 cursos con IA',
                'Acceso completo durante 7 días',
              ],
              price: 'GRATIS',
              color: Colors.grey.shade900,
              textColor: Colors.white,
              onPressed: () {
                Get.snackbar(
                  'Prueba activada',
                  'Tienes acceso por 7 días 🎉',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
            ),

            const SizedBox(height: 20),

            PlanCard(
              title: 'Paquete Mensual',
              features: [
                'Acceso a todos los juegos educativos',
                'Crea hasta 25 cursos con IA',
              ],
              price: '\$39.900 / mes',
              color:Colors.grey.shade900,
              textColor: Colors.white,
              onPressed: () {
                Get.to(() => PagosPremiumView(
                      plan: 'Paquete Mensual',
                      precio: '\$39.900 / mes',
                    ));
              },
            ),

            const SizedBox(height: 20),

            PlanCard(
              title: 'Paquete Anual',
              features: [
                'Acceso a todos los juegos educativos',
                'Creación ilimitada de cursos con IA',
                'Ahorra 2 meses con este plan',
              ],
              price: '\$359.000 / año',
              color:Colors.grey.shade900,
              textColor: Colors.white,
              onPressed: () {
                Get.to(() => PagosPremiumView(
                      plan: 'Paquete Anual',
                      precio: '\$359.000 / año',
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}