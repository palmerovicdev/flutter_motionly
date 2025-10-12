import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Controller personalizado para [WaveSticksLoader].
///
/// Permite controlar manualmente la animación del loader.
///
/// Ejemplo:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
///   late WaveStickAnimationController _controller;
///
///   @override
///   void initState() {
///     super.initState();
///     _controller = WaveStickAnimationController(
///       vsync: this,
///       duration: Duration(milliseconds: 1500),
///     )..start();
///   }
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   @override
///   Widget build(BuildContext context) {
///     return WaveSticksLoader(controller: _controller);
///   }
/// }
/// ```
class WaveStickAnimationController extends AnimationController {
  WaveStickAnimationController({
    required super.vsync,
    super.duration = const Duration(milliseconds: 1500),
  });

  /// Inicia la animación en loop infinito.
  void start() {
    repeat();
  }

  /// Detiene la animación y la resetea al inicio.
  void stopAnimation() {
    stop();
    reset();
  }
}

/// Widget de carga animado con efecto de onda gaussiana.
///
/// Crea un loader con múltiples barras (sticks) que se animan siguiendo
/// una distribución gaussiana, creando un efecto de onda suave que se
/// mueve de izquierda a derecha.
///
/// El parámetro [waveWidth] controla el ancho de la onda gaussiana,
/// garantizando que la animación siempre sea suave: la onda comienza
/// y termina fuera del área visible, asegurando que los sticks visibles
/// siempre tengan transiciones naturales.
///
/// Perfecto para:
/// - Estados de carga elegantes
/// - Visualizadores de audio
/// - Efectos de progreso creativos
/// - Indicadores de actividad
///
/// Ejemplo básico:
/// ```dart
/// WaveSticksLoader(
///   size: Size(350, 100),
///   duration: Duration(milliseconds: 1500),
///   numberOfSticks: 10,
///   stickWidth: 5,
///   stickHeight: 30,
///   middleWaveStickHeight: 45,
///   stickSpacing: 8,
///   stickColor: Colors.blue,
///   waveWidth: 1.5,
/// )
/// ```
///
/// Ejemplo de visualizador de audio:
/// ```dart
/// WaveSticksLoader(
///   size: Size(400, 120),
///   numberOfSticks: 20,
///   stickWidth: 4,
///   stickHeight: 20,
///   middleWaveStickHeight: 60,
///   stickColor: Colors.orange,
///   waveWidth: 2.0,
/// )
/// ```
///
/// Ver también:
/// - [WaveStickAnimationController] para control manual de la animación
class WaveSticksLoader extends StatefulWidget {
  const WaveSticksLoader({
    super.key,
    this.controller,
    this.duration = const Duration(milliseconds: 1500),
    this.size = const Size(100, 50),
    this.numberOfSticks = 5,
    this.stickWidth = 5.0,
    this.stickHeight = 20.0,
    this.middleWaveStickHeight = 30.0,
    this.stickColor = Colors.blue,
    this.stickSpacing = 5.0,
    this.alignment = CrossAxisAlignment.center,
    this.waveWidth = 1.5,
    this.radius = 2.5,
  });

  /// Duración de un ciclo completo de la animación.
  ///
  /// Un ciclo incluye el movimiento completo de la onda de izquierda a derecha.
  /// Valores recomendados: 800ms - 2000ms.
  final Duration duration;

  /// Controller opcional para controlar manualmente la animación.
  ///
  /// Si no se proporciona, se creará uno automáticamente.
  /// Útil cuando necesitas sincronizar múltiples loaders o
  /// controlar cuándo inicia/detiene la animación.
  final WaveStickAnimationController? controller;

  /// Tamaño total del contenedor del loader.
  ///
  /// Define el espacio que ocupará el widget completo.
  final Size size;

  /// Número de barras verticales (sticks) a mostrar.
  ///
  /// Valores recomendados:
  /// - 5-10: Para loaders simples
  /// - 15-25: Para efectos de visualizador de audio
  final int numberOfSticks;

  /// Ancho de cada stick individual en píxeles.
  final double stickWidth;

  /// Altura mínima de los sticks cuando están en reposo.
  ///
  /// Esta es la altura base que tendrán los sticks cuando
  /// la onda no esté pasando por ellos.
  final double stickHeight;

  /// Altura máxima que alcanza el stick en el centro de la onda.
  ///
  /// Debe ser mayor que [stickHeight] para que se vea el efecto.
  /// El valor representa la altura adicional que se suma a [stickHeight].
  final double middleWaveStickHeight;

  /// Espacio horizontal entre sticks en píxeles.
  ///
  /// Si [stickWidth] es grande, aumenta este valor proporcionalmente
  /// para evitar que los sticks se vean muy juntos.
  final double stickSpacing;

  /// Color de los sticks.
  final Color stickColor;

  /// Alineación vertical de los sticks dentro del contenedor.
  ///
  /// - [CrossAxisAlignment.center]: Sticks centrados verticalmente
  /// - [CrossAxisAlignment.start]: Sticks alineados arriba (útil para efecto espejo)
  /// - [CrossAxisAlignment.end]: Sticks alineados abajo (útil para efecto espejo)
  final CrossAxisAlignment alignment;

  /// Controla el ancho de la onda gaussiana.
  ///
  /// Valores más altos crean ondas más anchas y suaves.
  /// Valores más bajos crean ondas más concentradas y puntiagudas.
  ///
  /// La animación está diseñada para ser suave independientemente
  /// del valor: la onda siempre comienza y termina fuera del área
  /// visible, asegurando transiciones naturales.
  ///
  /// Rango recomendado:
  /// - 0.5 - 1.0: Onda estrecha y concentrada
  /// - 1.0 - 2.0: Onda media (equilibrada)
  /// - 2.0 - 3.0: Onda ancha y suave
  ///
  /// Guía según número de sticks:
  /// - 5-10 sticks: waveWidth 1.0-1.5
  /// - 10-15 sticks: waveWidth 1.5-2.0
  /// - 15+ sticks: waveWidth 2.0-2.5
  final double waveWidth;

  /// Radio de las esquinas de cada stick.
  ///
  /// Valores más altos crean sticks más redondeados.
  /// Para esquinas completamente redondeadas, usa [stickWidth] / 2.
  final double radius;

  @override
  State<WaveSticksLoader> createState() => _WaveSticksLoaderState();
}

class _WaveSticksLoaderState extends State<WaveSticksLoader> with TickerProviderStateMixin {
  late WaveStickAnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        widget.controller ??
              WaveStickAnimationController(
                vsync: this,
                duration: widget.duration,
              )
          ..start();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {

          final sigma = widget.numberOfSticks / 6 * widget.waveWidth;




          final startPosition = -3 * sigma;
          final endPosition = widget.numberOfSticks + 3 * sigma;


          final wavePosition = startPosition + _animationController.value * (endPosition - startPosition);

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: widget.alignment,
            children: List.generate(
              widget.numberOfSticks,
              (index) {
                final gaussHeight = _getHeightByGauss(
                  index.toDouble(),
                  sigma,
                  wavePosition,
                );
                return Container(
                  width: widget.stickWidth,
                  height: gaussHeight + widget.stickHeight,
                  margin: EdgeInsets.symmetric(horizontal: widget.stickSpacing / 2),
                  decoration: BoxDecoration(
                    color: widget.stickColor,
                    borderRadius: BorderRadius.circular(widget.radius),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Calcula la altura adicional del stick basado en la función gaussiana.
  ///
  /// [x] - Índice del stick
  /// [sigma] - Desviación estándar (controla el ancho de la campana)
  /// [u] - Posición del centro de la onda (media)
  ///
  /// Retorna la altura adicional calculada con la fórmula gaussiana:
  /// A * e^(-(x-u)²/(2σ²))
  double _getHeightByGauss(double x, double sigma, double u) {
    final A = widget.middleWaveStickHeight;
    final diff = (x - u) / sigma;
    final exponent = -math.pow(diff, 2) / 2;
    return A * math.pow(math.e, exponent);
  }
}
