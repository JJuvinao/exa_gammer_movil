import 'package:flutter/material.dart';

class BotonComenzar extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;

  const BotonComenzar({
    required this.width,
    required this.height,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: height,
      constraints: const BoxConstraints(minHeight: 50, maxHeight: 70),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00FF41), Color(0xFF00F0FF), Color(0xFF00FF41)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00FF41).withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 3,
          ),
          BoxShadow(
            color: const Color(0xFF00F0FF).withOpacity(0.4),
            blurRadius: 40,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'COMENZAR',
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                  color: Colors.black,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.black,
                  size: screenWidth * 0.06,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}