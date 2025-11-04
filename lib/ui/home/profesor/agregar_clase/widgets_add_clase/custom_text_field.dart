import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final bool enabled;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      style: TextStyle(
        color: enabled ? Colors.white : Colors.grey[500],
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: enabled ? Color(0xFF00F0FF) : Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: enabled 
                  ? [Color(0xFF00F0FF), Color(0xFF00FF41)]
                  : [Colors.grey[700]!, Colors.grey[800]!],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: enabled ? [
              BoxShadow(
                color: Color(0xFF00F0FF).withOpacity(0.3),
                blurRadius: 8,
              ),
            ] : [],
          ),
          child: Icon(
            icon,
            color: Colors.black,
            size: 20,
          ),
        ),
        filled: true,
        fillColor: enabled 
            ? Color(0xFF0f0f1e).withOpacity(0.6)
            : Color(0xFF0a0a14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFF00F0FF).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFF00F0FF),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red[400]!,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red[300]!,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: Colors.red[300],
          fontSize: 12,
        ),
      ),
    );
  }
}