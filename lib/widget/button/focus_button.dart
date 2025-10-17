import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Botón con un gradiente animado en el borde que rota continuamente.
///
/// Crea un efecto visual atractivo con un gradiente multicolor que se mueve
/// alrededor del borde del botón. Ideal para CTAs (Call To Action) y elementos
/// que requieren atención visual.
///
/// El gradiente utiliza [SweepGradient] con [GradientRotation] para crear
/// una animación fluida y continua.
///
/// Ejemplo básico:
/// ```dart
/// FocusButton(
///   child: Text(
///     'Click me',
///     style: TextStyle(color: Colors.white),
///   ),
///   onPressed: () => print('Pressed!'),
/// )
/// ```
///
/// Ejemplo con personalización completa:
/// ```dart
/// FocusButton(
///   child: Padding(
///     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
///     child: Row(
///       mainAxisSize: MainAxisSize.min,
///       children: [
///         Icon(Icons.star, color: Colors.white),
///         SizedBox(width: 8),
///         Text('Premium', style: TextStyle(color: Colors.white, fontSize: 16)),
///       ],
///     ),
///   ),
///   onPressed: () => upgradeToPremium(),
///   gradientColors: [
///     Colors.cyan,
///     Colors.blue,
///     Colors.purple,
///     Colors.pink,
///     Colors.cyan,
///   ],
///   borderWidth: 3.0,
///   borderRadius: 12.0,
///   backgroundColor: Colors.black87,
///   animationDuration: Duration(seconds: 3),
///   height: 56,
/// )
/// ```
///
/// Ejemplo con tamaño fijo:
/// ```dart
/// FocusButton(
///   width: 200,
///   height: 50,
///   borderRadius: 25, // Botón circular
///   child: Text('Botón fijo', style: TextStyle(color: Colors.white)),
///   onPressed: () {},
/// )
/// ```
class FocusButton extends StatefulWidget {
  /// Crea un [FocusButton].
  ///
  /// [child] es el widget que se mostrará dentro del botón (requerido).
  ///
  /// [onPressed] es el callback que se ejecuta al presionar el botón.
  /// Si es null, el botón no será interactivo.
  ///
  /// [gradientColors] define los colores del gradiente animado.
  /// Debe tener al menos 2 colores. Se recomienda repetir el primer color
  /// al final para una transición suave (ej: [azul, rosa, azul]).
  ///
  /// [borderWidth] controla el grosor del borde con gradiente.
  ///
  /// [borderRadius] define el radio de las esquinas del botón.
  ///
  /// [backgroundColor] es el color de fondo del contenido del botón.
  ///
  /// [animationDuration] controla la velocidad de rotación del gradiente.
  /// Un valor más bajo = rotación más rápida.
  ///
  /// [height] y [width] son opcionales. Si no se especifican, el botón
  /// se adaptará al tamaño de su hijo.
  const FocusButton({
    super.key,
    required this.child,
    this.onPressed,
    this.borderWidth = 2.0,
    this.gradientColors = const [
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.blue,
    ],
    this.duration = const Duration(seconds: 2),
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.black,
    this.height,
    this.width,
  }) : assert(gradientColors.length >= 2, 'Se requieren al menos 2 colores para el gradiente'),
        assert(borderWidth > 0, 'El ancho del borde debe ser mayor a 0'),
        assert(borderRadius >= 0, 'El radio del borde debe ser mayor o igual a 0');

  /// Widget hijo que se mostrará dentro del botón.
  final Widget child;

  /// Callback cuando se presiona el botón.
  /// Si es null, el botón no será interactivo.
  final VoidCallback? onPressed;

  /// Ancho del borde del gradiente animado.
  ///
  /// Por defecto: 2.0
  final double borderWidth;

  /// Colores del gradiente que se animará alrededor del borde.
  ///
  /// Se recomienda incluir al menos 3 colores y repetir el primero
  /// al final para una transición suave sin cortes visuales.
  ///
  /// Por defecto: [Colors.blue, Colors.purple, Colors.pink, Colors.orange, Colors.blue]
  final List<Color> gradientColors;

  /// Duración de una rotación completa del gradiente.
  ///
  /// Valores más bajos crean animaciones más rápidas.
  /// Valores más altos crean animaciones más lentas y suaves.
  ///
  /// Por defecto: 2 segundos
  final Duration duration;

  /// Radio de las esquinas del botón.
  ///
  /// Un valor de 0 crea esquinas cuadradas.
  /// Un valor igual a la mitad de la altura crea un botón completamente circular.
  ///
  /// Por defecto: 8.0
  final double borderRadius;

  /// Color de fondo del contenido del botón.
  ///
  /// Por defecto: Colors.black
  final Color backgroundColor;

  /// Altura del botón (opcional).
  ///
  /// Si es null, la altura se adapta al contenido del hijo.
  final double? height;

  /// Ancho del botón (opcional).
  ///
  /// Si es null, el ancho se adapta al contenido del hijo.
  final double? width;

  @override
  State<FocusButton> createState() => _FocusButtonState();
}

/// Estado del widget [FocusButton].
///
/// Maneja el [AnimationController] que controla la rotación del gradiente.
class _FocusButtonState extends State<FocusButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _GradientBorderPainter(
                progress: _controller.value,
                borderWidth: widget.borderWidth,
                gradientColors: widget.gradientColors,
                borderRadius: widget.borderRadius,
              ),
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                child: Center(child: widget.child),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Painter personalizado para dibujar el gradiente animado en el borde.
///
/// Utiliza [SweepGradient] con [GradientRotation] para crear un efecto
/// de gradiente que rota continuamente alrededor del borde del botón.
class _GradientBorderPainter extends CustomPainter {
  /// Progreso actual de la animación (0.0 a 1.0).
  final double progress;

  /// Ancho del borde a dibujar.
  final double borderWidth;

  /// Lista de colores del gradiente.
  final List<Color> gradientColors;

  /// Radio de las esquinas del borde.
  final double borderRadius;

  _GradientBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.gradientColors,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(borderRadius),
    );

    final gradient = SweepGradient(
      colors: gradientColors,
      startAngle: 0.0,
      endAngle: math.pi * 2,
      transform: GradientRotation(progress * math.pi * 2),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_GradientBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.borderWidth != borderWidth || oldDelegate.gradientColors != gradientColors || oldDelegate.borderRadius != borderRadius;
  }
}
