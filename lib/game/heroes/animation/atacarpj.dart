import 'package:flutter/material.dart';

class AnimatedAtacar extends StatefulWidget {
  final String imagePath;
  final double height;
  final double moveDistance;
  final Duration duration;

  const AnimatedAtacar({
    super.key,
    required this.imagePath,
    this.height = 180,
    this.moveDistance = 100,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedAtacar> createState() => _AnimatedAtacarState();
}

class _AnimatedAtacarState extends State<AnimatedAtacar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Movimiento con ida y vuelta
    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: widget.moveDistance,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: widget.moveDistance,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);

    // Inicia automáticamente
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Permite reiniciar la animación desde fuera si lo necesitas
  void playAnimation() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0), // movimiento horizontal
          child: child,
        );
      },
      child: Image.asset(widget.imagePath, height: widget.height),
    );
  }
}
