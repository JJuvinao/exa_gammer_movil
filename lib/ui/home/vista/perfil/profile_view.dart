import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';
import 'PremiumView.dart';
import 'EditarPerfil.dart';


class ProfileView extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  ProfileView({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1f1f2e),
        title: const Text("¿Cerrar sesión?", style: TextStyle(color: Colors.white)),
        content: const Text("¿Estás segura de que deseas salir?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar", style: TextStyle(color: Colors.cyan)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Salir", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await userController.logout();
      Get.offAll(() => Vistalogin());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = userController.getuser;
    final bool esPremium = user.premium == true;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a14),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0a0a14), Color(0xFF16213e), Color(0xFF0a0a14)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: esPremium ? Colors.amber : Colors.transparent,
                    width: 2,
                  ),
                ),
                color: const Color(0xFF1f1f2e),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    children: [
                      if (esPremium)
                      CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(user.img ?? ''),
                        backgroundColor: Colors.grey.shade800,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00F0FF),
                          shadows: [Shadow(color: Colors.cyan, blurRadius: 10)],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user.rol.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        esPremium ? "Cuenta Premium Activa" : "Cuenta Estándar",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: esPremium ? Colors.amber : Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 200,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Get.to(() => const PremiumView());
                          },
                          icon: const Icon(Icons.emoji_events, color: Colors.amber, size: 24),
                          label: const Text(
                            "Premium",
                            style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.amber),
                            backgroundColor: const Color(0xFF1f1f2e),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Get.dialog(
                                Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: const EditarPerfilView(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit, color: Colors.cyan),
                            label: const Text("Editar", style: TextStyle(color: Colors.cyan)),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xFF1f1f2e),
                              side: const BorderSide(color: Colors.cyan),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => _confirmLogout(context),
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text("Salir", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}