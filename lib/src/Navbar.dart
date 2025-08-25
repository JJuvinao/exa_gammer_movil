import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? botones;

  const Navbar({super.key, this.title, this.botones});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Usamos un Row para poner la imagen y el texto juntos
      title: Row(
        children: [
          Image.asset(
            'assets/logo_del_sitio.png',
            height: 60, // <-- Imagen más grande
          ),
          // Solo muestra el texto si el título no es nulo
          if (title != null) ...[
            const SizedBox(
              width: 10,
            ), // Un pequeño espacio entre la imagen y el texto
            Text(
              title!,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
            ),
          ],
        ],
      ),
      actions: botones,
      centerTitle: false, // <-- Cambiado a false para alinear a la izquierda
      backgroundColor: const Color.fromARGB(255, 120, 153, 193),
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
