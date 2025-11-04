import 'package:flutter/material.dart';

class FabNuevaClase extends StatelessWidget {
  final VoidCallback onPressed;

  const FabNuevaClase({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00FF41), Color(0xFF00F0FF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00FF41).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Color(0xFF00F0FF).withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.black),
        ),
        label: const Text(
          "Nueva clase",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}