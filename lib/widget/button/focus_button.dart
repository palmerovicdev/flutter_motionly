import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Botón con un **borde gradiente animado** que rota continuamente.
///
/// [FocusButton] dibuja un borde con un [SweepGradient] que gira 360°
/// de forma fluida usando [GradientRotation]. Es perfecto para CTAs,
/// botones de “Premium”, o cualquier elemento que necesite atención visual.
///
/// ## Características principales:
///
/// - **Borde animado 360°** con gradiente multicolor
/// - **Velocidad configurable** vía [animationDuration]
/// - **Totalmente personalizable**: colores, ancho de borde, radio, fondo y tamaño
/// - **Desktop/Web friendly**: cursor tipo *click*
///
/// ## Ejemplo básico:
///
/// ```dart
/// FocusButton(
///   child: Text('Click me', style: TextStyle(color: Colors.white)),
///   onClick: () => print('Pressed!'),
/// )
/// ```
///
/// ## Ejemplo con personalización completa:
///
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
///   onClick: upgradeToPremium,
///   gradientColors: [Colors.cyan, Colors.blue, Colors.purple, Colors.pink, Colors.cyan],
///   borderWidth: 3.0,
///   borderRadius: 12.0,
///   backgroundColor: Colors.black87,
///   animationDuration: Duration(seconds: 3),
///   height: 56,
/// )
/// ```
///
/// ## Ejemplo con tamaño fijo:
///
/// ```dart
/// FocusButton(
///   width: 200,
///   height: 50,
///   borderRadius: 25, // pill / circular
///   child: Text('Botón fijo', style: TextStyle(color: Colors.white)),
///   onClick: () {},
/// )
/// ```
///
/// ## Buenas prácticas:
///
/// - Repite el **primer color al final** en [gradientColors] para transiciones sin cortes.
/// - Para estilo *pill*, usa `borderRadius = (height ?? 48) / 2`.
/// - Súbele el *punch* visual con `borderWidth` entre 2–4 px.
/// - Mantén **alto contraste** entre [backgroundColor] y el contenido.
///
/// ## Consideraciones de rendimiento:
///
/// - La animación del borde es barata; evita anidar demasiados en listas muy largas.
/// - Usa `const` donde puedas en hijos y colores para reducir rebuilds.
///
/// Véase también:
///
/// - [PulsatingButton] para CTA con latido
/// - [RectRevealButton] / [RippleRevealButton] para efectos de revelado
class FocusButton extends StatefulWidget {
  /// Crea un [FocusButton].
  ///
  /// **Requeridos:**
  /// - [child]
  ///
  /// **Interacción:**
  /// - Usa [onClick] (o el alias [onPressed], deprecado).
  const FocusButton({
    super.key,
    required this.child,
    this.onClick,
    @Deprecated('Usa onClick en su lugar') this.onPressed,
    this.borderWidth = 2.0,
    this.gradientColors = const [
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.orange,
      Colors.blue, // repetir primero al final = transición suave
    ],
    this.animationDuration = const Duration(seconds: 2),
    @Deprecated('Usa animationDuration en su lugar') this.duration,
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.black,
    this.height,
    this.width,
  }) : assert(gradientColors.length >= 2, 'Se requieren al menos 2 colores para el gradiente'),
       assert(borderWidth > 0, 'El ancho del borde debe ser mayor a 0'),
       assert(borderRadius >= 0, 'El radio del borde debe ser >= 0');

  // -----------------------------
  // Contenido
  // -----------------------------

  /// Widget hijo que se mostrará dentro del botón (texto, icono, fila, etc.).
  final Widget child;

  // -----------------------------
  // Interacción
  // -----------------------------

  /// Callback recomendado cuando se presiona el botón.
  final VoidCallback? onClick;

  /// Alias deprecado de [onClick]. Se mantiene por compatibilidad.
  @Deprecated('Usa onClick en su lugar')
  final VoidCallback? onPressed;

  // -----------------------------
  // Estilo del borde
  // -----------------------------

  /// Ancho del borde del gradiente animado.
  ///
  /// Default: `2.0`
  final double borderWidth;

  /// Colores del gradiente que girará alrededor del borde.
  ///
  /// Recomendación: repite el primer color al final.
  ///
  /// Default: `[blue, purple, pink, orange, blue]`
  final List<Color> gradientColors;

  /// Radio de las esquinas del botón.
  ///
  /// Para *pill*, usa `height / 2`.
  ///
  /// Default: `8.0`
  final double borderRadius;

  // -----------------------------
  // Fondo & tamaño
  // -----------------------------

  /// Color de fondo del interior del botón.
  ///
  /// Default: `Colors.black`
  final Color backgroundColor;

  /// Alto del botón. Si es `null`, se adapta al hijo.
  final double? height;

  /// Ancho del botón. Si es `null`, se adapta al hijo.
  final double? width;

  // -----------------------------
  // Animación
  // -----------------------------

  /// Duración de una rotación completa del gradiente.
  ///
  /// Default: `2s`
  final Duration animationDuration;

  /// Alias deprecado de [animationDuration].
  @Deprecated('Usa animationDuration en su lugar')
  final Duration? duration;

  @override
  State<FocusButton> createState() => _FocusButtonState();
}

/// Estado de [FocusButton]: maneja la rotación del gradiente.
class _FocusButtonState extends State<FocusButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Duration get _effectiveDuration => widget.duration ?? widget.animationDuration;

  VoidCallback? get _onTap => widget.onClick ?? widget.onPressed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _effectiveDuration, vsync: this)..repeat();
  }

  @override
  void didUpdateWidget(FocusButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldDuration = oldWidget.duration ?? oldWidget.animationDuration;
    final newDuration = widget.duration ?? widget.animationDuration;
    if (oldDuration != newDuration) {
      _controller.duration = newDuration;
      if (!_controller.isAnimating) _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Si está deshabilitado, rebajamos un poco la opacidad para feedback visual.
    final bool disabled = _onTap == null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Opacity(
              opacity: disabled ? 0.7 : 1.0,
              child: CustomPaint(
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
                  alignment: Alignment.center,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Painter del borde gradiente animado (rotación 360°).
class _GradientBorderPainter extends CustomPainter {
  /// Progreso actual de la animación (0.0 → 1.0).
  final double progress;

  /// Ancho del borde.
  final double borderWidth;

  /// Lista de colores del gradiente.
  final List<Color> gradientColors;

  /// Radio de las esquinas.
  final double borderRadius;

  _GradientBorderPainter({
    required this.progress,
    required this.borderWidth,
    required this.gradientColors,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Área exterior
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Para que el stroke no “sangre” hacia afuera, inseteamos medio stroke.
    final inset = borderWidth / 2;
    final innerRect = Rect.fromLTWH(inset, inset, size.width - borderWidth, size.height - borderWidth);
    final innerRRect = RRect.fromRectAndRadius(innerRect, Radius.circular((borderRadius - inset).clamp(0, borderRadius)));

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

    canvas.drawRRect(innerRRect, paint);
  }

  @override
  bool shouldRepaint(_GradientBorderPainter old) {
    return old.progress != progress || old.borderWidth != borderWidth || old.gradientColors != gradientColors || old.borderRadius != borderRadius;
  }
}
