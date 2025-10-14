import 'dart:math';

import 'package:flutter/material.dart';

/// Indicador circular animado tipo “reveal por segmentos”.
///
/// Renderiza un anillo compuesto por `segmentCount` segmentos radiales que se
/// **revelan** en torno a un **segmento activo**. El segmento activo se
/// resalta con mayor **longitud** y **grosor**, y los segmentos adyacentes
/// pueden mostrar un efecto de **degradado** (halo) configurable mediante
/// `activeSegments`.
///
/// ### Modos de operación
/// - **Automático** (`animate: true` y `currentIndex == null`): rota el segmento
///   activo de forma continua según `animationDuration`.
/// - **Manual** (`currentIndex != null`): tú controlas el índice activo. Suele
///   usarse para sincronizar con un progreso o una lectura externa. En este
///   modo se ignora la animación interna (se detiene).
///
/// ### UX/Consejos
/// - Usa `activeColor` bien contrastado con `inactiveColor` para una lectura
///   clara, sobre todo con `strokeWidth` reducido.
/// - `activeSegments` crea un halo suave alrededor del activo; mantenerlo bajo
///   (2–4) suele producir un look elegante sin ruido visual.
/// - Si renderizas varios indicadores superpuestos (p. ej., efecto reloj),
///   envuélvelos en `Stack` y juega con `size`, `strokeWidth` y opacidades.
/// - `RepaintBoundary` ya está incluido para **evitar repaints innecesarios**
///   en padres cuando el indicador actualiza su frame.
///
/// ---
///
/// ### Ejemplo básico (auto-rotación)
/// ```dart
/// CircularRevealIndicator(
///   size: 120,
///   segmentCount: 12,
///   activeColor: Colors.blue,
///   inactiveColor: Colors.grey,
///   strokeWidth: 3,
///   animationDuration: const Duration(seconds: 2),
/// )
/// ```
///
/// ### Ejemplo con control manual
/// ```dart
/// // Avanza el índice desde afuera (por ejemplo, con un Timer)
/// int idx = 0;
/// Timer.periodic(const Duration(milliseconds: 100), (_) {
///   setState(() => idx = (idx + 1) % 60);
/// });
///
/// CircularRevealIndicator(
///   size: 80,
///   segmentCount: 60,
///   currentIndex: idx, // Control manual
///   animate: false,    // Desactiva animación interna
///   activeSegments: 4, // Halo un poco más ancho
/// )
/// ```
///
/// ### Ejemplo efecto “reloj” en capas
/// ```dart
/// Stack(
///   alignment: Alignment.center,
///   children: [
///     CircularRevealIndicator(
///       size: 200,
///       segmentCount: 60,
///       activeColor: Colors.cyan.withOpacity(0.3),
///       animationDuration: const Duration(minutes: 60), // horas/minutos
///     ),
///     CircularRevealIndicator(
///       size: 150,
///       segmentCount: 60,
///       activeColor: Colors.cyan.withOpacity(0.6),
///       animationDuration: const Duration(seconds: 60), // segundos
///     ),
///   ],
/// )
/// ```
///
/// ### Notas técnicas
/// - El layout del trazo se basa en líneas radiales cortas con `StrokeCap.round`,
///   ajustando **longitud** y **grosor** en función de la distancia al índice
///   activo.
/// - `shouldPaint: true` pinta también los segmentos *anteriores* como activos,
///   útil para simular **progreso acumulado**.
/// - `animationDuration` controla una vuelta completa del índice activo (modo automático).
class CircularRevealIndicator extends StatefulWidget {
  /// Crea un [CircularRevealIndicator].
  ///
  /// [size] es el tamaño del indicador circular.
  ///
  /// [segmentCount] es el número de segmentos que componen el círculo.
  ///
  /// [activeColor] es el color de los segmentos activos/revelados.
  ///
  /// [inactiveColor] es el color de los segmentos inactivos.
  ///
  /// [shouldPaint] controla si los segmentos anteriores al actual deben pintarse como activos.
  ///
  /// [currentIndex] permite control manual del índice del segmento activo.
  /// Si es null, la animación se controla automáticamente.
  ///
  /// [strokeWidth] es el grosor de los segmentos.
  ///
  /// [animationDuration] es la duración de una rotación completa.
  ///
  /// [activeSegments] es el número de segmentos cercanos al activo que deben
  /// resaltarse con efecto de degradado (halo). Valores 2–4 suelen verse bien.
  ///
  /// [animate] controla si el indicador debe animarse automáticamente
  /// (solo cuando [currentIndex] es null).
  ///
  /// #### Ejemplo de uso básico
  /// ```dart
  /// CircularRevealIndicator(
  ///   size: 120,
  ///   segmentCount: 12,
  ///   activeColor: Colors.blue,
  ///   inactiveColor: Colors.grey,
  ///   strokeWidth: 3,
  ///   animationDuration: Duration(seconds: 2),
  /// )
  /// ```
  ///
  /// #### Ejemplo con control manual
  /// ```dart
  /// CircularRevealIndicator(
  ///   size: 80,
  ///   segmentCount: 60,
  ///   currentIndex: 15, // Control manual
  ///   animate: false,
  /// )
  /// ```
  ///
  /// #### Ejemplo indicador de tiempo en capas
  /// ```dart
  /// Stack(
  ///   alignment: Alignment.center,
  ///   children: [
  ///     CircularRevealIndicator(
  ///       size: 200,
  ///       segmentCount: 60,
  ///       activeColor: Colors.cyan.withOpacity(0.3),
  ///       animationDuration: Duration(minutes: 60),
  ///     ),
  ///     CircularRevealIndicator(
  ///       size: 150,
  ///       segmentCount: 60,
  ///       activeColor: Colors.cyan.withOpacity(0.6),
  ///       animationDuration: Duration(seconds: 60),
  ///     ),
  ///   ],
  /// )
  /// ```
  const CircularRevealIndicator({
    super.key,
    this.size = 40.0,
    this.segmentCount = 12,
    this.activeColor = Colors.blue,
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.currentIndex,
    this.shouldPaint = true,
    this.strokeWidth = 2.0,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.activeSegments = 3,
    this.animate = true,
  });

  /// Tamaño total del indicador circular (ancho y alto).
  final double size;

  /// Número de segmentos que componen el círculo.
  final int segmentCount;

  /// Color de los segmentos activos/revelados.
  final Color activeColor;

  /// Color de los segmentos inactivos.
  final Color inactiveColor;

  /// Si `true`, pinta todos los segmentos **anteriores** al actual como activos
  /// (útil para simular progreso acumulado).
  final bool shouldPaint;

  /// Índice del segmento actualmente activo (para control manual).
  /// Si es `null`, el índice se controla automáticamente con la animación.
  final int? currentIndex;

  /// Grosor de los segmentos.
  final double strokeWidth;

  /// Duración de una **rotación completa** del indicador en modo automático.
  final Duration animationDuration;

  /// Número de segmentos adyacentes que muestran efecto de degradado (halo).
  final int activeSegments;

  /// Si el indicador debe animarse automáticamente (solo si [currentIndex] es `null`).
  final bool animate;

  @override
  State<CircularRevealIndicator> createState() => _CircularRevealIndicatorState();
}

/// Estado del widget [CircularRevealIndicator].
///
/// Gestiona el ciclo de animación en modo automático y sincroniza la duración
/// de la vuelta completa con `animationDuration`.
class _CircularRevealIndicatorState extends State<CircularRevealIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    if (widget.animate && widget.currentIndex == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(CircularRevealIndicator old) {
    super.didUpdateWidget(old);

    if (old.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }

    if (widget.animate && widget.currentIndex == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.animate || widget.currentIndex != null) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final index = widget.currentIndex ?? (_controller.value * widget.segmentCount).floor() % widget.segmentCount;
          return CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _CircularRevealPainter(
              shouldPaint: widget.shouldPaint,
              currentIndex: index,
              segmentCount: widget.segmentCount,
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
              strokeWidth: widget.strokeWidth,
              activeSegments: widget.activeSegments,
            ),
          );
        },
      ),
    );
  }
}

/// Painter de los segmentos circulares.
///
/// Dibuja `segmentCount` líneas radiales con `StrokeCap.round`. La **longitud**
/// y el **grosor** aumentan en el segmento activo y decrecen suavemente en los
/// adyacentes (definidos por `activeSegments`), creando un **degradado radial**
/// alrededor del índice activo.
///
/// - Si `shouldPaint` es `true`, los segmentos **anteriores** al índice activo
///   se pintan con `activeColor` para simular **progreso**.
/// - El resto se pinta con `inactiveColor`.
class _CircularRevealPainter extends CustomPainter {
  /// Índice del segmento actualmente activo.
  final int currentIndex;

  /// Número total de segmentos.
  final int segmentCount;

  /// Color de los segmentos activos.
  final Color activeColor;

  /// Color de los segmentos inactivos.
  final Color inactiveColor;

  /// Grosor base de los segmentos.
  final double strokeWidth;

  /// Número de segmentos adyacentes con efecto degradado (halo).
  final int activeSegments;

  /// Si debe pintar todos los segmentos anteriores como activos (progreso).
  final bool shouldPaint;

  _CircularRevealPainter({
    required this.currentIndex,
    required this.segmentCount,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeWidth,
    required this.activeSegments,
    required this.shouldPaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;
    final radius = (size.width - strokeWidth) / 2;

    final segmentLength = radius * 0.15;
    final angleStep = (2 * pi) / segmentCount;

    canvas.translate(center, center);

    for (int i = 0; i < segmentCount; i++) {
      final isCurrentSegment = i == currentIndex;
      final distance = _getDistanceFromCurrent(i);
      double length;

      if (isCurrentSegment) {
        length = segmentLength * 1.7;
      } else if (distance != null) {
        length = segmentLength * (1.5 - (distance / activeSegments) * 0.5);
        if (length < segmentLength) length = segmentLength;
      } else {
        length = segmentLength;
      }

      final width = isCurrentSegment ? strokeWidth * 1.3 : strokeWidth;
      final color = i == currentIndex
          ? activeColor
          : currentIndex > i && shouldPaint
          ? activeColor
          : inactiveColor;

      final startY = -(radius - segmentLength / 2 - length / 2);
      final endY = -(radius - segmentLength / 2 + length / 2);

      canvas.drawLine(
        Offset(0, startY),
        Offset(0, endY),
        Paint()
          ..color = color
          ..strokeWidth = width
          ..strokeCap = StrokeCap.round,
      );

      canvas.rotate(angleStep);
    }
  }

  /// Distancia (0..activeSegments-1) de un segmento respecto al **activo**.
  ///
  /// Retorna `null` si el índice está fuera del rango de influencia (sin halo).
  int? _getDistanceFromCurrent(int index) {
    for (int i = 0; i < activeSegments; i++) {
      if ((currentIndex - i + segmentCount) % segmentCount == index) return i;
      if ((currentIndex + i) % segmentCount == index) return i;
    }
    return null;
  }

  @override
  bool shouldRepaint(_CircularRevealPainter old) =>
      old.currentIndex != currentIndex ||
      old.segmentCount != segmentCount ||
      old.activeColor != activeColor ||
      old.inactiveColor != inactiveColor ||
      old.strokeWidth != strokeWidth ||
      old.activeSegments != activeSegments ||
      old.shouldPaint != shouldPaint;
}
