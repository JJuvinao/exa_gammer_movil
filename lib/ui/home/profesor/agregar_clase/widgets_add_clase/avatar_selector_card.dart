import 'package:flutter/material.dart';
import 'package:exa_gammer_movil/ui/home/widget/avatares.dart';

class AvatarSelectorCard extends StatelessWidget {
  final List<String> avatarList;
  final bool mostrarAvatar;
  final String? avatarSeleccionado;
  final Function(String avatar) onAvatarSelected;

  const AvatarSelectorCard({
    super.key,
    required this.avatarList,
    required this.mostrarAvatar,
    required this.avatarSeleccionado,
    required this.onAvatarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF00FF41).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00FF41).withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header con icono
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00FF41), Color(0xFF00F0FF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00FF41).withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Icon(Icons.image_rounded, color: Colors.black, size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Imagen de la clase',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF41),
                  shadows: [
                    Shadow(
                      color: Color(0xFF00FF41),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Selecciona una imagen representativa',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          _buildAvatarPreview(),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00FF41), Color(0xFF00F0FF)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF00FF41).withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () async {
                final avatar = await AvatarSelectorModal.show(context, avatarList);
                if (avatar != null) onAvatarSelected(avatar);
              },
              icon: const Icon(Icons.photo_library_rounded, color: Colors.black),
              label: Text(
                mostrarAvatar ? 'Cambiar imagen' : 'Seleccionar imagen',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPreview() {
    if (mostrarAvatar && avatarSeleccionado != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xFF00FF41),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF00FF41).withOpacity(0.6),
              blurRadius: 20,
              spreadRadius: 3,
            ),
            BoxShadow(
              color: Color(0xFF00F0FF).withOpacity(0.4),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            avatarSeleccionado!,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFF0f0f1e),
            Color(0xFF1a1a2e),
          ],
        ),
        border: Border.all(
          color: Color(0xFF00FF41).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.image_rounded,
        size: 50,
        color: Colors.grey[600],
      ),
    );
  }
}