import 'dart:math';

import 'package:flutter/material.dart';

/// Modos de efecto difuso disponibles para el texto.
///
/// Cada modo aplica un tipo diferente de distorsión visual al texto.
enum FuzzyMode {
  /// Efecto glitch con desplazamiento horizontal de capas de color.
  ///
  /// Crea un efecto de "fallo digital" desplazando capas rojas y azules
  /// en direcciones opuestas horizontalmente.
  glitch,

  /// Efecto de fluctuación de altura/escala.
  ///
  /// Hace que el texto fluctúe ligeramente en tamaño, creando un efecto
  /// de "respiración" o vibración sutil.
  height,
}

/// Texto con efectos difusos animados que simula fallos digitales o fluctuaciones.
///
/// Crea efectos visuales dinámicos aplicando transformaciones aleatorias al texto
/// de forma continua. Soporta dos **modos principales** ([FuzzyMode]):
/// - **Glitch**: Desplazamiento horizontal de capas de color (rojo/azul)
/// - **Height**: Fluctuación de escala/tamaño del texto
///
/// ### Cómo funciona
/// - Usa un `AnimationController` en bucle infinito para generar cambios continuos.
/// - Cada frame aplica transformaciones aleatorias basadas en [amplitude] y [mode].
/// - Para el modo `glitch`: superpone capas de texto con colores desplazados.
/// - Para el modo `height`: aplica escalado aleatorio al texto base.
///
/// ### Rendimiento
/// - La animación corre a 60fps por defecto (duración de 900ms en bucle).
/// - Usa `Random` para generar valores aleatorios en cada frame.
/// - Es relativamente liviano, pero ten cuidado con múltiples instancias.
///
/// ### Consejos de UX
/// - `FuzzyMode.height` es más sutil y menos distractor.
/// - `FuzzyMode.glitch` es más dramático, ideal para efectos especiales.
/// - Ajusta [amplitude] para controlar la intensidad del efecto.
/// - Usa [debugBox] durante desarrollo para visualizar los límites.
///
/// ---
///
/// ### Ejemplo básico (modo glitch)
/// ```dart
/// FuzzyText.glitch(
///   'ERROR 404',
///   style: TextStyle(
///     fontSize: 32,
///     fontWeight: FontWeight.bold,
///     color: Colors.white,
///   ),
///   amplitude: 8.0,
/// )
/// ```
///
/// ### Ejemplo modo height (efecto sutil)
/// ```dart
/// FuzzyText.height(
///   'Cargando...',
///   style: TextStyle(
///     fontSize: 24,
///     color: Colors.blue,
///   ),
///   amplitude: 6.0,
/// )
/// ```
///
/// ### Ejemplo con configuración personalizada
/// ```dart
/// FuzzyText.glitch(
///   'SISTEMA CORRUPTO',
///   style: TextStyle(
///     fontSize: 28,
///     fontFamily: 'Courier',
///     color: Colors.green,
///   ),
///   amplitude: 15.0,
///   speed: 2.0,
///   debugBox: true, // Solo para desarrollo
/// )
/// ```
///
/// ### Notas
/// - El widget se autocentra y usa `FittedBox` para ajustarse al contenido.
/// - La animación inicia automáticamente y corre indefinidamente.
/// - Para detener la animación, desmonta el widget del árbol.
/// - El color base del texto se respeta, las capas glitch usan rojo/azul.
class FuzzyText extends StatefulWidget {
  /// El texto a mostrar con efectos difusos.
  final String text;

  /// Estilo del texto base. Se respeta el color para el modo [FuzzyMode.height].
  /// En modo [FuzzyMode.glitch] se usan capas adicionales roja y azul.
  final TextStyle style;

  /// Modo de efecto difuso a aplicar.
  final FuzzyMode mode;

  /// Amplitud del efecto. Controla qué tan pronunciado es el efecto.
  ///
  /// - Para [FuzzyMode.glitch]: distancia máxima de desplazamiento horizontal.
  /// - Para [FuzzyMode.height]: factor de escalado máximo (como porcentaje).
  ///
  /// Valores típicos: 6-20. Valores muy altos pueden ser molestos visualmente.
  final double amplitude;

  /// Velocidad de la animación (actualmente no implementado).
  ///
  /// Reservado para futuras implementaciones donde se pueda controlar
  /// la velocidad del ciclo de animación.
  final double speed;

  /// Si es `true`, muestra un borde rosa alrededor del widget para debug.
  ///
  /// Útil durante desarrollo para visualizar los límites del widget.
  /// **No usar en producción.**
  final bool debugBox;

  /// Constructor privado. Usa los factory constructors [FuzzyText.glitch] o [FuzzyText.height].
  const FuzzyText._(
    this.text, {
    super.key,
    required this.style,
    required this.mode,
    this.amplitude = 12,
    this.speed = 1.6,
    this.debugBox = false,
  });

  /// Crea un [FuzzyText] con efecto glitch.
  ///
  /// El efecto glitch superpone capas de texto con colores rojo y azul
  /// desplazadas horizontalmente en direcciones opuestas, simulando
  /// un fallo digital o corrupción de datos.
  ///
  /// [text] es el texto a mostrar.
  ///
  /// [style] define la apariencia del texto base.
  ///
  /// [amplitude] controla qué tan lejos se desplazan las capas de color.
  /// Valores típicos: 8-16 píxeles.
  ///
  /// [speed] reservado para futuras implementaciones.
  ///
  /// [debugBox] muestra un borde para debug (solo desarrollo).
  ///
  /// #### Ejemplo
  /// ```dart
  /// FuzzyText.glitch(
  ///   'SISTEMA ERROR',
  ///   style: TextStyle(fontSize: 24, color: Colors.white),
  ///   amplitude: 10.0,
  /// )
  /// ```
  factory FuzzyText.glitch(
    String text, {
    required TextStyle style,
    Key? key,
    double amplitude = 12,
    double speed = 1.6,
    bool debugBox = false,
  }) => FuzzyText._(
    text,
    key: key,
    style: style,
    mode: FuzzyMode.glitch,
    amplitude: amplitude,
    speed: speed,
    debugBox: debugBox,
  );

  /// Crea un [FuzzyText] con efecto de fluctuación de altura.
  ///
  /// El efecto height hace que el texto fluctúe ligeramente en escala,
  /// creando una sensación de "respiración" o vibración sutil.
  /// Es menos agresivo visualmente que el modo glitch.
  ///
  /// [text] es el texto a mostrar.
  ///
  /// [style] define la apariencia del texto (se respeta completamente).
  ///
  /// [amplitude] controla qué tan pronunciada es la fluctuación.
  /// Se traduce a un factor de escala. Valores típicos: 6-15.
  ///
  /// [speed] reservado para futuras implementaciones.
  ///
  /// [debugBox] muestra un borde para debug (solo desarrollo).
  ///
  /// #### Ejemplo
  /// ```dart
  /// FuzzyText.height(
  ///   'Procesando...',
  ///   style: TextStyle(fontSize: 18, color: Colors.blue),
  ///   amplitude: 8.0,
  /// )
  /// ```
  factory FuzzyText.height(
    String text, {
    required TextStyle style,
    Key? key,
    double amplitude = 12,
    double speed = 1.6,
    bool debugBox = false,
  }) => FuzzyText._(
    text,
    key: key,
    style: style,
    mode: FuzzyMode.height,
    amplitude: amplitude,
    speed: speed,
    debugBox: debugBox,
  );

  @override
  State<FuzzyText> createState() => _FuzzyTextState();
}

class _FuzzyTextState extends State<FuzzyText> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) => _buildGlitchOrHeight(),
        ),
      ),
    );
  }

  Widget _buildGlitchOrHeight() {
    final offset = (_rng.nextDouble() - 0.5) * widget.amplitude;

    final base = Text(
      widget.text,
      textAlign: TextAlign.center,
      style: widget.style,
    );

    final red = Text(
      widget.text,
      textAlign: TextAlign.center,
      style: widget.style.copyWith(color: Colors.redAccent),
    );

    final blue = Text(
      widget.text,
      textAlign: TextAlign.center,
      style: widget.style.copyWith(color: Colors.blueAccent),
    );

    Widget child = Stack(
      alignment: Alignment.center,
      children: [
        if (widget.mode == FuzzyMode.glitch) Transform.translate(offset: Offset(offset, 0), child: red),
        if (widget.mode == FuzzyMode.height)
          Transform.scale(
            scale: 1 + (_rng.nextDouble() - 0.5) * 0.1,
            child: base,
          ),
        if (widget.mode == FuzzyMode.glitch) Transform.translate(offset: Offset(-offset, 0), child: blue),
      ],
    );

    if (widget.debugBox) {
      child = DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: Colors.pinkAccent)),
        child: Padding(padding: const EdgeInsets.all(2), child: child),
      );
    }
    return child;
  }
}
