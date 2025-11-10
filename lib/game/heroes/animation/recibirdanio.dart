import 'package:flutter/material.dart';

class AnimatedBattleCharacter extends StatefulWidget {
  final String imagePath;
  final bool recibioDanio;
  final bool estaMuerto;
  final double height;

  const AnimatedBattleCharacter({
    super.key,
    required this.imagePath,
    required this.recibioDanio,
    required this.estaMuerto,
    this.height = 180,
  });

  @override
  State<AnimatedBattleCharacter> createState() =>
      _AnimatedBattleCharacterState();
}

class _AnimatedBattleCharacterState extends State<AnimatedBattleCharacter>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _fadeAnimation = Tween<double>(begin: 1, end: 0).animate(_fadeController);
  }

  @override
  void didUpdateWidget(covariant AnimatedBattleCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Cuando el personaje muere, se desvanece
    if (widget.estaMuerto && !_fadeController.isAnimating) {
      _fadeController.forward();
    }
    // Cuando revive, vuelve a aparecer
    else if (!widget.estaMuerto && oldWidget.estaMuerto) {
      _fadeController.reverse();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: widget.recibioDanio
              ? Colors.red.withOpacity(0.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Image.asset(widget.imagePath, height: widget.height),
      ),
    );
  }
}
