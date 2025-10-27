import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final List<String> features;
  final String price;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const PlanCard({
    super.key,
    required this.title,
    required this.features,
    required this.price,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  f,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(price,
                style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: textColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onPressed,
                child: const Text(
                  'Seleccionar plan',
                  style: TextStyle(fontSize: 16, fontFamily: 'Inter'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
