import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/ui/home/widget/Plan_card.dart';
import 'package:exa_gammer_movil/ui/home/vista/Pago_premium.dart';

class PremiumView extends StatelessWidget {
  const PremiumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8C1C1),
      appBar: AppBar(
        title: const Text(
          'Planes Premium',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFC8C1C1),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 16),

            // Plan gratuito
            PlanCard(
              title: 'Prueba Gratis (7 días)',
              features: [
                'Crea hasta 5 cursos con IA',
                'Acceso completo durante 7 días',
              ],
              price: 'GRATIS',
              color: Colors.grey.shade800,
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

            // Plan mensual
            PlanCard(
              title: 'Paquete Mensual',
              features: [
                'Acceso a todos los juegos educativos',
                'Crea hasta 25 cursos con IA',
              ],
              price: '\$39.900 / mes',
              color: const Color(0xFF0D59A1),
              textColor: Colors.white,
              onPressed: () {
                Get.to(() => PagosPremiumView(
                      plan: 'Paquete Mensual',
                      precio: '\$39.900 / mes',
                    ));
              },
            ),

            const SizedBox(height: 20),

            // Plan anual
            PlanCard(
              title: 'Paquete Anual',
              features: [
                'Acceso a todos los juegos educativos',
                'Creación ilimitada de cursos con IA',
                'Ahorra 2 meses con este plan',
              ],
              price: '\$359.000 / año',
              color: Colors.amber.shade400,
              textColor: Colors.black,
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

