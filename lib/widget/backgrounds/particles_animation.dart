import 'dart:math';

import 'package:flutter/material.dart';

class Particle {
  late Offset position;
  late Offset velocity;
  late double size;
  late Color color;
  final Random _random = Random();
  final List<Color> colors;
  final int heightFactor;
  final double velocityFactor;
  final double maxWidth;
  final double maxHeight;
  final double velocityYDirection;
  final double velocityXDirection;

  Particle({
    required this.colors,
    this.heightFactor = 4,
    this.velocityFactor = 1.5,
    this.maxWidth = 800,
    this.maxHeight = 800,
    this.velocityYDirection = 1,
    this.velocityXDirection = 1,
  }) {
    reset();
  }

  reset() {
    position = Offset(_getAxis(maxWidth), _getAxis(maxHeight));
    _buildVelocity();
    size = _random.nextDouble() * _random.nextInt(heightFactor) + 1;
    color = colors[_random.nextInt(colors.length)].withAlpha(100);
  }

  void _buildVelocity({bool? y, bool? x}) {
    final vY = y ?? (velocityXDirection >= 0) ? _getVelocity() : -_getVelocity();
    final vX = x ?? (velocityXDirection >= 0) ? _getVelocity() : -_getVelocity();
    velocity = Offset(vX, vY);
  }

  update({bool? y, bool? x}) {
    if (y != null || x != null) {
      _buildVelocity(y: y, x: x);
    }
    position += velocity;
    if (position.dx < 0 || position.dx > maxWidth || position.dy < 0 || position.dy > maxHeight) {
      reset();
    }
  }

  double _getVelocity() => _random.nextDouble() * velocityFactor;

  double _getAxis(double factor) => _random.nextDouble() * factor;
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var p in particles) {
      paint.color = p.color;
      canvas.drawCircle(p.position, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticleBox extends StatefulWidget {
  const ParticleBox({
    super.key,
    required this.colors,
    this.heightFactor = 4,
    this.velocityFactor = 0.5,
    this.particleCount = 150,
    this.maxWidth = 800,
    this.maxHeight = 800,
    this.backgroundColor = Colors.transparent,
  });

  final List<Color> colors;
  final int heightFactor;
  final double velocityFactor;
  final int particleCount;
  final double maxWidth;
  final double maxHeight;
  final Color backgroundColor;

  @override
  State<ParticleBox> createState() => _ParticleBoxState();
}

class _ParticleBoxState extends State<ParticleBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  var _lastMousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(
      widget.particleCount,
      (index) => Particle(
        colors: widget.colors,
        heightFactor: widget.heightFactor,
        velocityFactor: widget.velocityFactor,
        maxWidth: widget.maxWidth,
        maxHeight: widget.maxHeight,
        velocityXDirection: Random().nextBool() ? 1 : -1,
        velocityYDirection: Random().nextBool() ? 1 : -1,
      ),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: MouseRegion(
          onHover: (event) => setState(() {
            final delta = event.position - _lastMousePosition;
            final directionY = delta.dy >= 0 ? 1 : -1;
            final directionX = delta.dx >= 0 ? 1 : -1;
            for (var p in _particles) {
              p.update(y: directionY == 1, x: directionX == 1);
            }
            _lastMousePosition = event.position;
          }),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              for (var p in _particles) {
                p.update();
              }
              return CustomPaint(
                painter: ParticlePainter(_particles),
                size: MediaQuery.of(context).size,
              );
            },
          ),
        ),
      ),
    );
  }
}
