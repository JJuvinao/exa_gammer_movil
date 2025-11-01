import 'package:exa_gammer_movil/models/user_model.dart';
import 'package:flutter/material.dart';

class Listaperso extends StatelessWidget {
  final List<User> users;

  const Listaperso({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
              child: Icon(Icons.person, color: Colors.blueAccent.shade700),
            ),
            title: Text(
              user.username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              user.email,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        );
      },
    );
  }
}
