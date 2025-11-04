import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:flutter/material.dart';

class Listaperso extends StatelessWidget {
  final List<User> users;

  const Listaperso({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F0F1E), Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
      ),
      child: ListView.separated(
        itemCount: users.length,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final user = users[index];
          return _buildUserCard(user, index);
        },
      ),
    );
  }

  Widget _buildUserCard(User user, int index) {
    // Alternar colores de avatar
    final isEven = index % 2 == 0;
    final gradientColors = isEven
        ? [Color(0xFF00F0FF), Color(0xFF00FF41)]
        : [Color(0xFF00FF41), Color(0xFF00F0FF)];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF00F0FF).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00F0FF).withOpacity(0.15),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Avatar con efecto glow
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: gradientColors),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withOpacity(0.5),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF1a1a2e),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        gradientColors[0].withOpacity(0.3),
                        gradientColors[1].withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.person_rounded,
                    color: gradientColors[0],
                    size: 28,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Info del usuario
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00F0FF),
                      shadows: [
                        Shadow(
                          color: Color(0xFF00F0FF).withOpacity(0.3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.email_rounded,
                        size: 14,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          user.email,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[400],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
