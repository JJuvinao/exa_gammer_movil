import 'package:flutter/material.dart';

class PlanCard extends StatelessWidget {
  final String title;
  final List<String> features;
  final String price;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isPremium;

  const PlanCard({
    super.key,
    required this.title,
    required this.features,
    required this.price,
    required this.color,
    required this.textColor,
    required this.onPressed,
    this.isPremium = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium ? Colors.amber : const Color(0xFF0D59A1),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: isPremium
                ? Colors.amber.withOpacity(0.4)
                : Colors.blueAccent.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPremium)
            const Center(
              child: Icon(Icons.emoji_events, color: Colors.amber, size: 36),
            ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 10),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.check_circle,
                        color: isPremium ? Colors.amber : Colors.cyan, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(color: textColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Text(
            price,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isPremium ? Colors.amber : Colors.cyan.shade400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                "Seleccionar",
                style: TextStyle(
                  color: isPremium ? Colors.amber : Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}