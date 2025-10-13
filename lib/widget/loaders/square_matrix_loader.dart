import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_motionly/common/utils.dart';

/// Clase auxiliar para representar un cuadrado en la matriz con su altura animada.
///
/// Cada cuadrado mantiene su propia altura que se anima según la onda
/// que atraviesa la matriz, y un índice para identificarlo.
class SquareHeight {
  /// Altura actual del cuadrado (se anima durante la reproducción).
  double height;

  /// Índice único del cuadrado en la matriz aplanada.
  int index;

  SquareHeight({
    required this.height,
    required this.index,
  });
}

/// Widget de carga animado con matriz de cuadrados que se expanden y contraen.
///
/// Crea un loader con una cuadrícula de cuadrados que se animan siguiendo
/// diferentes patrones direccionales, creando efectos visuales dinámicos
/// y modernos mediante transformaciones de escala.
///
/// Los cuadrados se expanden y contraen en secuencia según la dirección
/// especificada, utilizando una onda sinusoidal para crear transiciones
/// suaves. Soporta 8 direcciones diferentes: vertical, horizontal y
/// cuatro variantes diagonales.
///
/// Perfecto para:
/// - Estados de carga modernos y elegantes
/// - Indicadores de progreso creativos
/// - Pantallas de splash animadas
/// - Transiciones visuales atractivas
///
/// Ejemplo básico:
/// ```dart
/// SquareMatrixLoader(
///   numberOfSquares: 4,
///   squareHeight: 40,
///   duration: Duration(milliseconds: 1500),
///   color: Colors.blue,
///   direction: TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
/// )
/// ```
///
/// Ejemplo con efecto diagonal:
/// ```dart
/// SquareMatrixLoader(
///   numberOfSquares: 5,
///   squareHeight: 35,
///   duration: Duration(milliseconds: 1800),
///   color: Colors.orange,
///   direction: TraverseDirection.RIGHT_BOTTOM_LEFT_UP,
///   curve: Curves.easeInOut,
/// )
/// ```
///
/// Ejemplo con matriz grande:
/// ```dart
/// SquareMatrixLoader(
///   numberOfSquares: 6,
///   squareHeight: 25,
///   duration: Duration(milliseconds: 2000),
///   color: Colors.purple,
///   direction: TraverseDirection.UP_BOTTOM,
///   curve: Curves.linear,
/// )
/// ```
///
/// Ver también:
/// - [TraverseDirection] para las direcciones de animación disponibles
class SquareMatrixLoader extends StatefulWidget {
  /// Crea un [SquareMatrixLoader].
  ///
  /// [numberOfSquares] define el tamaño de la matriz (3 = 3x3, 4 = 4x4, etc).
  /// Valores recomendados: 3-6. Valores más altos pueden afectar el rendimiento.
  ///
  /// [squareHeight] es el tamaño de cada cuadrado en píxeles.
  /// El tamaño total del loader será: squareHeight × numberOfSquares.
  ///
  /// [duration] controla la velocidad de la animación. Matrices más grandes
  /// se ven mejor con duraciones más largas (1500ms+).
  ///
  /// [color] es el color de los cuadrados.
  ///
  /// [direction] determina el patrón de animación. Opciones disponibles:
  /// - BOTTOM_UP: De abajo hacia arriba
  /// - UP_BOTTOM: De arriba hacia abajo
  /// - LEFT_RIGHT: De izquierda a derecha
  /// - RIGHT_LEFT: De derecha a izquierda
  /// - LEFT_UP_RIGHT_BOTTOM: Diagonal superior izquierda a inferior derecha
  /// - RIGHT_BOTTOM_LEFT_UP: Diagonal inferior derecha a superior izquierda
  /// - LEFT_BOTTOM_RIGHT_UP: Diagonal inferior izquierda a superior derecha
  /// - RIGHT_UP_LEFT_BOTTOM: Diagonal superior derecha a inferior izquierda
  ///
  /// [curve] es la curva de animación para las transiciones.
  /// [Curves.linear] crea un efecto constante, mientras que [Curves.easeInOut]
  /// produce transiciones más suaves.
  const SquareMatrixLoader({
    super.key,
    this.numberOfSquares = 3,
    this.duration = const Duration(milliseconds: 1500),
    this.curve = Curves.linear,
    this.squareHeight = 40,
    this.direction = TraverseDirection.LEFT_UP_RIGHT_BOTTOM,
    this.color = Colors.blue,
  });

  /// Duración de un ciclo completo de la animación.
  ///
  /// Un ciclo incluye la expansión y contracción completa de todos los cuadrados.
  ///
  /// Valores recomendados según tamaño de matriz:
  /// - 3x3: 1000ms - 1500ms
  /// - 4x4: 1500ms - 2000ms
  /// - 5x5 o más: 2000ms+
  final Duration duration;

  /// Curva de animación para las transiciones.
  ///
  /// Controla cómo se acelera o desacelera la animación.
  ///
  /// Curvas recomendadas:
  /// - [Curves.linear]: Velocidad constante, efecto mecánico
  /// - [Curves.easeInOut]: Suave inicio y fin, muy natural
  /// - [Curves.bounceInOut]: Efecto rebote, más juguetón
  /// - [Curves.elasticInOut]: Efecto elástico, más dramático
  final Curve curve;

  /// Número de cuadrados en cada fila y columna de la matriz.
  ///
  /// Una matriz de 3 tendrá 9 cuadrados (3×3), una de 4 tendrá 16 (4×4), etc.
  ///
  /// Recomendaciones de rendimiento:
  /// - 3-4: Excelente rendimiento, ideal para la mayoría de casos
  /// - 5-6: Buen rendimiento, visualmente más complejo
  /// - 7+: Puede afectar el rendimiento en dispositivos lentos
  final int numberOfSquares;

  /// Altura y ancho de cada cuadrado individual en píxeles.
  ///
  /// El tamaño total del loader será:
  /// `squareHeight × numberOfSquares` (más espaciado interno).
  ///
  /// Valores recomendados:
  /// - 20-30: Loader compacto
  /// - 30-40: Tamaño medio, versátil
  /// - 40-50: Loader grande, más visible
  final double squareHeight;

  /// Dirección en la que fluye la animación a través de la matriz.
  ///
  /// Determina el patrón de recorrido de la onda por los cuadrados.
  /// Las direcciones diagonales crean efectos más dinámicos y modernos.
  ///
  /// Opciones:
  /// - Verticales: [TraverseDirection.UP_BOTTOM], [TraverseDirection.BOTTOM_UP]
  /// - Horizontales: [TraverseDirection.LEFT_RIGHT], [TraverseDirection.RIGHT_LEFT]
  /// - Diagonales: 4 variantes desde cada esquina
  final TraverseDirection direction;

  /// Color de los cuadrados.
  ///
  /// Se recomienda usar colores con buen contraste respecto al fondo
  /// para que el efecto de animación sea claramente visible.
  final Color color;

  @override
  State<SquareMatrixLoader> createState() => _SquareMatrixLoaderState();
}

class _SquareMatrixLoaderState extends State<SquareMatrixLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late List<List<SquareHeight>> _matrix;
  late List<List<SquareHeight>> _traversed;
  late double cellSize;
  late double squareSize;

  @override
  void initState() {
    super.initState();

    cellSize = widget.squareHeight;
    squareSize = cellSize * 0.8;

    _matrix = _generateMatrix();
    _traversed = traverseMatrix(_matrix, widget.direction);

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cellSize * widget.numberOfSquares,
      width: cellSize * widget.numberOfSquares,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          int diagonalIndex = 0;
          for (var diagonal in _traversed) {
            double offset = diagonalIndex / _traversed.length;
            for (var square in diagonal) {
              square.height = _calculateHeight(_animation.value, offset);
            }
            diagonalIndex++;
          }

          return Stack(
            children: List.generate(
              widget.numberOfSquares * widget.numberOfSquares,
              (index) {
                final row = index ~/ widget.numberOfSquares;
                final col = index % widget.numberOfSquares;
                final square = _matrix[row][col];

                final scale = square.height / widget.squareHeight;

                return Positioned(
                  left: col * cellSize + (cellSize - squareSize) / 2,
                  top: row * cellSize + (cellSize - squareSize) / 2,
                  child: Transform.scale(
                    scale: scale,
                    child: Container(
                      width: squareSize,
                      height: squareSize,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Genera la matriz inicial de cuadrados.
  ///
  /// Crea una matriz cuadrada de [numberOfSquares] × [numberOfSquares],
  /// asignando a cada cuadrado un índice único y altura inicial.
  List<List<SquareHeight>> _generateMatrix() {
    var i = 0;
    return List.generate(
      widget.numberOfSquares,
      (_) {
        return List.generate(
          widget.numberOfSquares,
          (_) => SquareHeight(height: widget.squareHeight, index: i++),
        );
      },
    );
  }

  /// Calcula la altura animada de un cuadrado usando una onda sinusoidal.
  ///
  /// [t] es el tiempo actual de la animación (0.0 a 1.0).
  /// [offset] es la posición del cuadrado en el recorrido (0.0 a 1.0).
  ///
  /// La altura oscila entre el 30% y 100% de [squareHeight],
  /// creando un efecto de pulsación suave.
  double _calculateHeight(double t, double offset) {
    double wave = sin((t + offset) * 2 * pi);
    double normalized = (wave + 1) / 2;
    normalized = 0.3 + (normalized * 0.7);

    return widget.squareHeight * normalized;
  }
}
