import 'package:exa_gammer_movil/ui/home/inicio_sesion/diseologin.dart';
import 'package:exa_gammer_movil/ui/home/profesor/Home_Profesor/widgets_home_profesor/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exa_gammer_movil/controllers/user_controller.dart';
import 'package:exa_gammer_movil/ui/home/vista/perfil/PremiumView.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final UserController userController = Get.find<UserController>();

  Future<bool> _confirmLogout() async {
    final shouldLogout = await showLogoutDialog(context);

    if (shouldLogout == true) {
      await userController.logout();
      Get.offAll(() => Vistalogin());
    }

    return false; // evita que se cierre automáticamente
  }

  @override
  Widget build(BuildContext context) {
    final user = userController.getuser;

    return WillPopScope(
      onWillPop: _confirmLogout,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 219, 219),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Perfil del Usuario"),
          backgroundColor: const Color(0xFFC8C1C1),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.img!),
                ),
                const SizedBox(height: 20),
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.email,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  "Rol: ${user.rol}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                if (user.rol.toLowerCase() != 'estudiante')
                  Center(
                    child: SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const PremiumView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade400,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Premium",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC8C1C1),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Get.snackbar(
                          "Editar perfil",
                          "Función aún no implementada",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.black),
                      label: const Text(
                        "Editar perfil",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _confirmLogout();
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Cerrar sesión"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
