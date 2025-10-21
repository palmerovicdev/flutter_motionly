import 'dart:math';

import 'package:flutter/material.dart';

/// Representa una partícula individual en el sistema de partículas.
///
/// Cada partícula tiene posición, velocidad, tamaño y color únicos.
/// Se mueve continuamente y se regenera cuando sale del área visible.
/// Representa una partícula individual en el sistema de partículas.
///
/// Cada partícula tiene posición, velocidad, tamaño y color únicos.
/// Se mueve continuamente y se regenera cuando sale del área visible.
/// Representa una partícula individual en el sistema de partículas.
///
/// Cada partícula tiene posición, velocidad, tamaño y color únicos.
/// Se mueve continuamente y se regenera cuando sale del área visible.
/// Representa una partícula individual en el sistema de partículas.
///
/// Cada partícula tiene posición, velocidad, tamaño y color únicos.
/// Se mueve continuamente y se regenera cuando sale del área visible.
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

  /// Crea una nueva partícula con parámetros configurables.
  ///
  /// La partícula se inicializa automáticamente con posición, velocidad,
  /// tamaño y color aleatorios mediante [reset].
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

  /// Reinicia la partícula con valores aleatorios.
  ///
  /// Se llama cuando:
  /// Construye el vector de velocidad de la partícula.
  ///
  /// Parámetros opcionales [x] e [y] permiten forzar direcciones específicas:
  /// - `true` = dirección positiva (derecha/abajo)
  /// - `false` = dirección negativa (izquierda/arriba)
  /// - `null` = usa las direcciones iniciales [velocityXDirection] y [velocityYDirection]
  /// - La partícula se crea por primera vez
  /// - La partícula sale del área visible
  ///
  /// Genera:
  /// - Posición aleatoria dentro del área [maxWidth] × [maxHeight]
  /// - Velocidad aleatoria basada en [velocityFactor]
  /// Actualiza la posición de la partícula y verifica límites.
  ///
  /// Si se proporcionan [x] o [y], actualiza la dirección de velocidad.
  /// Mueve la partícula según su velocidad actual.
  /// Si sale del área visible, la reinicia con [reset].
/// Painter personalizado que dibuja todas las partículas en el canvas.
///
/// Se repinta en cada frame para mostrar el movimiento fluido de las partículas.
  ///
  /// Lista de partículas a renderizar.
  /// Este método se llama en cada frame de animación.
  /// - Tamaño aleatorio basado en [heightFactor]
  /// Crea un painter con la lista de partículas proporcionada.
  /// - Color aleatorio de la lista [colors] con alpha semi-transparente
  reset() {
    position = Offset(_getAxis(maxWidth), _getAxis(maxHeight));
    _buildVelocity();
    size = _random.nextDouble() * _random.nextInt(heightFactor) + 1;
    // Dibuja cada partícula como un círculo
/// Widget de fondo animado con sistema de partículas en movimiento continuo.
///
/// Genera partículas circulares que se mueven aleatoriamente por el área visible,
/// creando un efecto dinámico e interactivo perfecto para fondos modernos.
///
/// **Ideal para:** fondos de landing pages, pantallas de bienvenida, overlays
/// decorativos, efectos de ambiente tipo espacio/nieve/burbujas, y cualquier
/// diseño que necesite movimiento orgánico y fluido.
///
/// ## Cómo funciona
///
/// - Cada **partícula** se mueve con velocidad y dirección únicas.
/// - Los **colores** se seleccionan aleatoriamente de la lista proporcionada.
/// - Las partículas se **regeneran** automáticamente al salir del área visible.
/// - Incluye **interactividad con mouse** (hover) que afecta la dirección del movimiento.
///
/// ## Anatomía del efecto
///
/// ```
/// Área de animación:
/// Estado interno de [ParticleBox].
///
/// Maneja el ciclo de vida del [AnimationController], la lista de partículas
/// y la interactividad con el mouse.
/// ╔════════════════════════════╗
  /// Controller que mantiene la animación en loop infinito.
/// ║  ●      ●         ●    ●  ║  ← Partículas moviéndose

  /// Lista de todas las partículas activas.
/// ║        ●    ●             ║

  /// Última posición conocida del mouse para calcular dirección de movimiento.
/// ║  ●              ●         ║
/// ║       ●    ●        ●     ║
/// ║  ●         ●    ●         ║
/// ╚════════════════════════════╝
///    ↑ Cada una con:
    // Generar partículas con direcciones aleatorias
///    - Posición única
///    - Velocidad única
///    - Tamaño único
///    - Color aleatorio de la paleta
/// ```
///
/// ## Rendimiento
///
/// - **Optimizado** para renderizar cientos de partículas a 60fps.
/// - **Recomendado:** 50-150 partículas en móviles.
/// - **Máximo:** 300-500 partículas para mantener rendimiento en la mayoría de dispositivos.
/// - Las partículas fuera de pantalla se reciclan en lugar de destruirse.
    // Iniciar animación infinita
///
/// ## Buenas prácticas
///
/// - Usa **colores con alpha** (0.4-0.7) para efectos sutiles y elegantes.
/// - Mantén **velocityFactor bajo** (0.2-0.4) para movimiento suave y relajante.
/// - Ajusta **particleCount** según el tamaño de pantalla y potencia del dispositivo.
/// - Para efecto "estrellas": muchas partículas pequeñas (heightFactor bajo).
/// - Para efecto "burbujas": pocas partículas grandes (heightFactor alto).
///
/// ## Ejemplos
///
/// ### Ejemplo básico (fondo elegante)
/// ```dart
/// ParticleBox(
///   maxHeight: 400,
///   maxWidth: MediaQuery.of(context).size.width,
///   velocityFactor: 0.3,
///   particleCount: 150,
          // Detectar movimiento del mouse y actualizar dirección de partículas
///   heightFactor: 5,
///   colors: [
///     Colors.blue.withValues(alpha: 0.6),
///     Colors.purple.withValues(alpha: 0.6),
            // Actualizar dirección de todas las partículas según el movimiento del mouse
///     Colors.pink.withValues(alpha: 0.6),
///   ],
///   backgroundColor: Colors.black,
/// )
/// ```
///
/// ### Ejemplo efecto estrellas
/// ```dart
              // Actualizar posición de cada partícula en cada frame
/// ParticleBox(
///   maxHeight: 600,
///   maxWidth: 800,
///   velocityFactor: 0.15,
///   particleCount: 100,
///   heightFactor: 3,
///   colors: [
///     Colors.white.withValues(alpha: 0.8),
///     Colors.blue[100]!.withValues(alpha: 0.6),
///     Colors.purple[100]!.withValues(alpha: 0.5),
///   ],
///   backgroundColor: Colors.black,
/// )
/// ```
///
/// ### Ejemplo energético (muchas partículas rápidas)
/// ```dart
/// ParticleBox(
///   maxHeight: 300,
///   maxWidth: 600,
///   velocityFactor: 0.5,
///   particleCount: 300,
///   heightFactor: 8,
///   colors: [
///     Colors.red.withValues(alpha: 0.7),
///     Colors.orange.withValues(alpha: 0.7),
///     Colors.yellow.withValues(alpha: 0.7),
///   ],
/// )
/// ```
///
/// ### Ejemplo océano digital (tonos azules)
/// ```dart
/// ParticleBox(
///   maxHeight: 280,
///   maxWidth: 400,
///   velocityFactor: 0.25,
///   particleCount: 200,
///   heightFactor: 6,
///   colors: [
///     Colors.blue[300]!.withValues(alpha: 0.5),
///     Colors.blue[500]!.withValues(alpha: 0.5),
///     Colors.lightBlue[400]!.withValues(alpha: 0.5),
///   ],
/// )
/// ```
///
/// ### Ejemplo en contenedor personalizado
/// ```dart
/// Container(
///   height: 400,
///   width: double.infinity,
///   child: ClipRRect(
///     borderRadius: BorderRadius.circular(16),
///     child: ParticleBox(
///       maxHeight: 400,
///       maxWidth: MediaQuery.of(context).size.width,
///       velocityFactor: 0.3,
///       particleCount: 150,
///       colors: [Colors.cyan.withValues(alpha: 0.6)],
///       backgroundColor: Colors.black87,
///     ),
///   ),
/// )
/// ```
///
/// ## Interactividad
///
/// El componente responde al movimiento del mouse (en plataformas de escritorio):
/// - Mover el cursor afecta la dirección de las partículas cercanas
/// - Crea una sensación de inmersión y profundidad
///
/// Ver también: [FlickTileBox] para efectos de tiles parpadeantes.
    color = colors[_random.nextInt(colors.length)].withAlpha(100);
  }

  void _buildVelocity({bool? y, bool? x}) {
  /// Genera una velocidad aleatoria basada en [velocityFactor].
    final vY = y ?? (velocityXDirection >= 0) ? _getVelocity() : -_getVelocity();
  /// Siempre repinta porque las partículas están en constante movimiento.
    final vX = x ?? (velocityXDirection >= 0) ? _getVelocity() : -_getVelocity();
  /// Genera una posición aleatoria dentro del rango [0, factor].
    velocity = Offset(vX, vY);
  }

  /// Lista de colores para las partículas.
  ///
  /// Cada partícula selecciona un color aleatorio de esta lista.
  /// Se recomienda usar colores con alpha (semi-transparentes) para
  /// efectos más sutiles y elegantes.
  ///
  /// Ejemplo:
  /// ```dart
  /// colors: [
  ///   Colors.blue.withValues(alpha: 0.6),
  ///   Colors.purple.withValues(alpha: 0.6),
  /// ]
  /// ```
  update({bool? y, bool? x}) {

  /// Factor que determina la variación de tamaño de las partículas.
  ///
  /// Un valor más alto genera partículas más grandes.
  ///
  /// - **2-4**: Partículas muy pequeñas (efecto estrellas/polvo)
  /// - **4-6**: Tamaño equilibrado (recomendado)
  /// - **7-10**: Partículas grandes (efecto burbujas)
    if (y != null || x != null) {

  /// Multiplicador de velocidad de movimiento de las partículas.
  ///
  /// Controla qué tan rápido se mueven las partículas por la pantalla.
  ///
  /// - **0.1-0.25**: Muy lento y relajante
  /// - **0.25-0.4**: Velocidad moderada (recomendado)
  /// - **0.4-0.6**: Rápido y dinámico
  /// - **> 0.6**: Muy rápido (puede marear)
      _buildVelocity(y: y, x: x);

  /// Número total de partículas a renderizar.
  ///
  /// Más partículas = efecto más denso pero mayor costo de rendimiento.
  ///
  /// Recomendaciones por dispositivo:
  /// - **Móviles**: 50-150 partículas
  /// - **Tablets**: 150-250 partículas
  /// - **Desktop**: 200-500 partículas
    }

  /// Ancho máximo del área de animación en píxeles.
  ///
  /// Las partículas se mueven dentro de este rango horizontal.
  /// Típicamente se establece al ancho de la pantalla:
  /// ```dart
  /// maxWidth: MediaQuery.of(context).size.width
  /// ```
    position += velocity;

  /// Altura máxima del área de animación en píxeles.
  ///
  /// Las partículas se mueven dentro de este rango vertical.
  /// Debe coincidir con la altura del contenedor padre.
    if (position.dx < 0 || position.dx > maxWidth || position.dy < 0 || position.dy > maxHeight) {

  /// Color de fondo del canvas.
  ///
  /// Si es `Colors.transparent` (por defecto), el fondo es transparente
  /// y se verá lo que esté detrás del widget.
  ///
  /// Si se proporciona un color sólido, se dibuja como fondo antes
  /// de las partículas.
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
