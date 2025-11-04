import 'package:flutter/material.dart';

class CreateButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const CreateButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: isLoading
            ? LinearGradient(
                colors: [Colors.grey[700]!, Colors.grey[800]!],
              )
            : LinearGradient(
                colors: [
                  Color(0xFF00FF41),
                  Color(0xFF00F0FF),
                  Color(0xFF00FF41),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: isLoading
            ? []
            : [
                BoxShadow(
                  color: Color(0xFF00FF41).withOpacity(0.5),
                  blurRadius: 25,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Color(0xFF00F0FF).withOpacity(0.3),
                  blurRadius: 35,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white70,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'CREAR CLASE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}