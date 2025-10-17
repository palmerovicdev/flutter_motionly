import 'package:flutter/material.dart';

/// Un botón animado con **efecto de pulsación tipo latido**.
///
/// [PulsatingButton] crea un halo que se expande y contrae suavemente alrededor
/// de un botón central, combinando cambios de **escala** y **opacidad** para
/// atraer la atención del usuario.
///
/// ## Características principales:
///
/// - **Pulsación continua** (loop infinito con reversa)
/// - **Halo con opacidad dinámica** que se desvanece al expandirse
/// - **Radio animado** sincronizado con la pulsación
/// - **Personalizable**: duración, tamaño, color, curva, borde y radio
/// - **Desktop/Web friendly**: cursor tipo *click*
///
/// ## Casos de uso ideales:
///
/// - CTA principales (“Comenzar”, “Comprar”, “Grabar”)
/// - Botones de bienvenida o pantallas vacías
/// - Llamar la atención en onboarding/notificaciones
///
/// ## Ejemplo básico:
///
/// ```dart
/// PulsatingButton(
///   onClick: () => print('¡Botón presionado!'),
///   child: Text('Comenzar', style: TextStyle(color: Colors.white, fontSize: 16)),
/// )
/// ```
///
/// ## Ejemplo personalizado:
///
/// ```dart
/// PulsatingButton(
///   onClick: _handleAction,
///   color: Colors.red,
///   width: 200,
///   height: 70,
///   pulsationDuration: Duration(milliseconds: 1000),
///   pulsationSize: 20,
///   curve: Curves.easeInOutCubic,
///   borderRadius: BorderRadius.circular(35),
///   child: Row(
///     mainAxisAlignment: MainAxisAlignment.center,
///     children: [
///       Icon(Icons.play_arrow, color: Colors.white),
///       SizedBox(width: 8),
///       Text('Reproducir', style: TextStyle(color: Colors.white)),
///     ],
///   ),
/// )
/// ```
///
/// ## Ejemplo con borde (outline):
///
/// ```dart
/// PulsatingButton(
///   onClick: _onPressed,
///   color: Colors.transparent,
///   border: Border.all(color: Colors.purple, width: 2),
///   width: 150,
///   height: 50,
///   pulsationSize: 15,
///   child: Text('Suscribirse', style: TextStyle(color: Colors.purple)),
/// )
/// ```
///
/// ## Buenas prácticas:
///
/// - 1–2 instancias por pantalla para no saturar la UI
/// - Mantén contraste entre [color] y el **child**
/// - Para *pill look*: `borderRadius = BorderRadius.circular(height / 2)`
///
/// ## Consideraciones de rendimiento:
///
/// - Animación permanente: úsalo con moderación (especialmente en listas)
/// - Envuelto en [RepaintBoundary] para aislar repaints del resto del árbol
///
/// Véase también:
///
/// - [AnimatedStateButton] para múltiples estados
/// - [FocusButton] para borde gradiente animado 360°
/// - [RippleRevealButton] / [RectRevealButton] para efectos de revelado
class PulsatingButton extends StatefulWidget {
  /// Crea un botón con efecto de pulsación continua.
  ///
  /// El ciclo se ejecuta indefinidamente hasta que el widget se descarte.
  const PulsatingButton({
    super.key,
    this.onClick,
    @Deprecated('Usa onClick en su lugar') this.onPressed,
    this.color = Colors.blue,
    this.pulsationDuration = const Duration(milliseconds: 800),
    this.width = 120.0,
    this.height = 60.0,
    this.border,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.child,
    this.curve = Curves.easeInOut,
    this.pulsationSize = 12.0,
  }) : assert(width > 0, 'width debe ser > 0'),
       assert(height > 0, 'height debe ser > 0'),
       assert(pulsationSize >= 0, 'pulsationSize debe ser >= 0');

  // -----------------------------
  // Interacción
  // -----------------------------

  /// Callback al presionar el botón.
  ///
  /// Si es `null`, el botón seguirá pulsando pero no responderá a toques.
  final VoidCallback? onClick;

  /// Alias deprecado para mantener compatibilidad con código legacy.
  @Deprecated('Usa onClick en su lugar')
  final VoidCallback? onPressed;

  // -----------------------------
  // Estilo base
  // -----------------------------

  /// Color del botón central y base del halo.
  ///
  /// El halo usa este color con opacidad variable.
  final Color color;

  /// Borde opcional del botón central (no se anima).
  final BoxBorder? border;

  /// Radio de esquinas del botón y base para el halo.
  final BorderRadius? borderRadius;

  /// Contenido del botón (texto, icono, fila, etc.).
  final Widget? child;

  // -----------------------------
  // Tamaño
  // -----------------------------

  /// Ancho del botón central (sin contar la expansión del halo).
  final double width;

  /// Alto del botón central (sin contar la expansión del halo).
  final double height;

  // -----------------------------
  // Animación
  // -----------------------------

  /// Duración de un ciclo completo (expandir + contraer).
  final Duration pulsationDuration;

  /// Curva de animación aplicada a la pulsación.
  final Curve curve;

  /// Número de píxeles que el halo se expande en cada dirección.
  final double pulsationSize;

  @override
  State<PulsatingButton> createState() => _PulsatingButtonState();
}

class _PulsatingButtonState extends State<PulsatingButton> with SingleTickerProviderStateMixin {
  /// Controlador de la animación de pulsación (loop con reversa).
  late AnimationController _controller;

  /// Animación con curva aplicada (0.0 → 1.0).
  late Animation<double> _animation;

  VoidCallback? get _onTap => widget.onClick ?? widget.onPressed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.pulsationDuration)..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didUpdateWidget(covariant PulsatingButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pulsationDuration != widget.pulsationDuration) {
      _controller.duration = widget.pulsationDuration;
      if (!_controller.isAnimating) _controller.repeat(reverse: true);
    }
    if (oldWidget.curve != widget.curve) {
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _clamp01(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);

  @override
  Widget build(BuildContext context) {
    final double maxWidth = widget.width + widget.pulsationSize;
    final double maxHeight = widget.height + widget.pulsationSize;
    final bool disabled = _onTap == null;

    return SizedBox(
      width: maxWidth,
      height: maxHeight,
      child: Center(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                final double scaleW = widget.width + (_animation.value * widget.pulsationSize);
                final double scaleH = widget.height + (_animation.value * widget.pulsationSize);

                final double baseR = (widget.borderRadius?.topLeft.x ?? 12.0);
                final double animR = baseR + (_animation.value * 4);

                final double haloOpacity = _clamp01(1 / (_animation.value + 1));

                return GestureDetector(
                  onTap: _onTap,
                  behavior: HitTestBehavior.opaque,
                  child: Opacity(
                    opacity: disabled ? 0.7 : 1.0,
                    child: Container(
                      width: scaleW,
                      height: scaleH,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(haloOpacity),
                        borderRadius: widget.borderRadius?.copyWith(
                          bottomLeft: Radius.circular(animR),
                          bottomRight: Radius.circular(animR),
                          topLeft: Radius.circular(animR),
                          topRight: Radius.circular(animR),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        decoration: BoxDecoration(
                          color: widget.color,
                          border: widget.border,
                          borderRadius: widget.borderRadius,
                        ),
                        alignment: Alignment.center,
                        child: widget.child,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
