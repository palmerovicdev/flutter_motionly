import 'package:flutter/material.dart';

/// Botón animado con efecto *ripple/circular reveal* que alterna entre dos estados.
///
/// Genera un círculo que se expande desde el punto del toque hasta cubrir
/// el área del botón, creando una transición suave entre dos contenidos
/// y dos esquemas de color.
///
/// **Ideal para:** toggles, switches personalizados, botones de favorito/like,
/// modo claro/oscuro, y cualquier control que requiera feedback visual claro.
///
/// ## Cómo funciona
///
/// - El **fondo** alterna entre `selectedBackgroundColor` y `unselectedBackgroundColor`.
/// - El **ripple** dibuja un círculo del color correspondiente al estado destino.
/// - El **contenido** alterna entre `selectedChild` (seleccionado) y `unselectedChild` (no seleccionado).
///
/// ## Anatomía del efecto
///
/// ```
/// Estado inicial: NO SELECCIONADO
/// ┌─────────────────────┐
/// │  unselectedChild    │  ← Fondo: unselectedBackgroundColor
/// └─────────────────────┘
///
/// Al tocar:
/// ┌─────────────────────┐
/// │    ●────────────     │  ← Círculo expandiéndose (selectedRippleColor)
/// └─────────────────────┘
///
/// Estado final: SELECCIONADO
/// ┌─────────────────────┐
/// │   selectedChild     │  ← Fondo: selectedBackgroundColor
/// └─────────────────────┘
/// ```
///
/// ## Buenas prácticas
///
/// - Usa **colores contrastantes** entre fondo y ripple para maximizar el impacto visual.
/// - Asegúrate de que `selectedChild` y `unselectedChild` sean visualmente distintos.
/// - Para esquinas suaves, incrementa `borderRadius` (mínimo 2.0).
/// - Si controlas el estado externamente, usa `isSelected` y actualízalo con `setState`.
///
/// ## Ejemplos
///
/// ### Ejemplo básico (toggle ON/OFF)
/// ```dart
/// RippleRevealButton(
///   selectedChild: const Text(
///     'ON',
///     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
///   ),
///   unselectedChild: const Text(
///     'OFF',
///     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
///   ),
///   selectedBackgroundColor: Colors.black,
///   unselectedBackgroundColor: Colors.white,
///   selectedRippleColor: Colors.black,
///   unselectedRippleColor: Colors.white,
///   onPressed: () => debugPrint('¡Alternado!'),
/// )
/// ```
///
/// ### Ejemplo con iconos (favorito)
/// ```dart
/// RippleRevealButton(
///   selectedChild: const Icon(Icons.favorite, color: Colors.white),
///   unselectedChild: const Icon(Icons.favorite_border, color: Colors.red),
///   selectedBackgroundColor: Colors.red,
///   unselectedBackgroundColor: Colors.grey.shade100,
///   selectedRippleColor: Colors.red,
///   unselectedRippleColor: Colors.grey.shade300,
///   height: 56,
///   width: 56,
///   borderRadius: 28,
///   onPressed: () => print('Favorito alternado'),
/// )
/// ```
///
/// ### Ejemplo con control externo
/// ```dart
/// class MyToggle extends StatefulWidget {
///   const MyToggle({super.key});
///
///   @override
///   State<MyToggle> createState() => _MyToggleState();
/// }
///
/// class _MyToggleState extends State<MyToggle> {
///   bool _isActive = false;
///
///   @override
///   Widget build(BuildContext context) {
///     return RippleRevealButton(
///       isSelected: _isActive,
///       selectedChild: const Text('Activo'),
///       unselectedChild: const Text('Inactivo'),
///       selectedBackgroundColor: Colors.blue,
///       unselectedBackgroundColor: Colors.grey.shade200,
///       selectedRippleColor: Colors.blue,
///       unselectedRippleColor: Colors.grey,
///       onPressed: () => setState(() => _isActive = !_isActive),
///     );
///   }
/// }
/// ```
///
/// ### Ejemplo con borde decorativo
/// ```dart
/// RippleRevealButton(
///   selectedChild: const Text(
///     'Premium',
///     style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
///   ),
///   unselectedChild: const Text('Básico'),
///   selectedBackgroundColor: Colors.black,
///   unselectedBackgroundColor: Colors.white,
///   selectedRippleColor: Colors.amber,
///   unselectedRippleColor: Colors.black,
///   border: Border.all(color: Colors.amber, width: 2),
///   borderRadius: 16,
///   height: 56,
///   onPressed: () => print('Plan cambiado'),
/// )
/// ```
///
/// ## Notas técnicas
///
/// - El cursor se establece automáticamente a `click` en plataformas desktop.
/// - El ripple se origina en las coordenadas exactas del tap.
/// - `animationDuration` controla la velocidad de la expansión circular.
/// - El widget es completamente responsivo y se adapta al tamaño disponible.
///
class RippleRevealButton extends StatefulWidget {
  /// Crea un [RippleRevealButton] con efecto de ripple circular.
  ///
  /// **Parámetros requeridos:**
  /// - [selectedChild]: Widget mostrado cuando el botón está seleccionado.
  /// - [unselectedChild]: Widget mostrado cuando el botón NO está seleccionado.
  /// - [onPressed]: Callback ejecutado al presionar el botón.
  ///
  /// **Personalización de colores:**
  /// - [selectedBackgroundColor]: Color de fondo en estado seleccionado (por defecto: negro).
  /// - [unselectedBackgroundColor]: Color de fondo en estado no seleccionado (por defecto: blanco).
  /// - [selectedRippleColor]: Color del ripple hacia estado seleccionado (por defecto: blanco).
  /// - [unselectedRippleColor]: Color del ripple hacia estado no seleccionado (por defecto: negro).
  ///
  /// **Dimensiones y apariencia:**
  /// - [width]: Ancho del botón (por defecto: 120).
  /// - [height]: Alto del botón (por defecto: 48).
  /// - [borderRadius]: Radio de las esquinas, mínimo 2.0 (por defecto: 2).
  /// - [border]: Borde decorativo opcional.
  /// - [padding]: Espaciado interno del contenido (por defecto: horizontal 16).
  /// - [alignment]: Alineación del contenido (por defecto: centrado).
  ///
  /// **Control de estado:**
  /// - [isSelected]: Controla el estado desde el widget padre. Si no se provee,
  ///   el botón gestiona su propio estado interno.
  /// - [animationDuration]: Duración de la animación (por defecto: 300ms).
  ///
  /// **Ejemplo:**
  /// ```dart
  /// RippleRevealButton(
  ///   selectedChild: const Icon(Icons.check),
  ///   unselectedChild: const Icon(Icons.close),
  ///   onPressed: () => print('Pulsado'),
  /// )
  /// ```
  const RippleRevealButton({
    super.key,
    required Widget selectedChild,
    Widget? unselectedChild,
    required this.onPressed,
    Color? selectedBackgroundColor,
    Color? unselectedBackgroundColor,
    Color? selectedRippleColor,
    Color? unselectedRippleColor,
    this.width = double.infinity,
    this.height = 48,
    double? borderRadius,
    Duration? animationDuration,
    bool? isSelected,
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = Alignment.center,
    @Deprecated('Use selectedChild instead. Will be removed in v2.0.0') Widget? widgetA,
    @Deprecated('Use unselectedChild instead. Will be removed in v2.0.0') Widget? widgetB,
    @Deprecated('Use selectedBackgroundColor instead. Will be removed in v2.0.0') Color? backgroundColorA,
    @Deprecated('Use unselectedBackgroundColor instead. Will be removed in v2.0.0') Color? backgroundColorB,
    @Deprecated('Use selectedRippleColor instead. Will be removed in v2.0.0') Color? rippleColorA,
    @Deprecated('Use unselectedRippleColor instead. Will be removed in v2.0.0') Color? rippleColorB,
    @Deprecated('Use borderRadius instead. Will be removed in v2.0.0') double? radius,
    @Deprecated('Use animationDuration instead. Will be removed in v2.0.0') Duration? duration,
    @Deprecated('Use isSelected instead. Will be removed in v2.0.0') bool? selected,
  }) : selectedChild = widgetA ?? selectedChild,
       unselectedChild = widgetB ?? unselectedChild,
       selectedBackgroundColor = backgroundColorA ?? selectedBackgroundColor ?? Colors.black,
       unselectedBackgroundColor = backgroundColorB ?? unselectedBackgroundColor ?? Colors.white,
       selectedRippleColor = rippleColorA ?? selectedRippleColor ?? Colors.white,
       unselectedRippleColor = rippleColorB ?? unselectedRippleColor ?? Colors.black,
       borderRadius = radius ?? borderRadius ?? 2,
       animationDuration = duration ?? animationDuration ?? const Duration(milliseconds: 300),
       isSelected = selected ?? isSelected,
       assert((radius ?? borderRadius ?? 2) >= 2, 'borderRadius debe ser al menos 2.0 para un renderizado correcto');

  /// Widget mostrado cuando el botón está en estado **seleccionado**.
  ///
  /// Aparece junto con [selectedBackgroundColor] después de la animación del ripple.
  final Widget selectedChild;

  /// Widget mostrado cuando el botón está en estado **no seleccionado**.
  ///
  /// Aparece junto con [unselectedBackgroundColor] después de la animación del ripple.
  final Widget? unselectedChild;

  /// Color de fondo cuando el botón está **seleccionado**.
  ///
  /// Por defecto es `Colors.black`. Debe contrastar con [selectedRippleColor]
  /// para un efecto visual óptimo.
  final Color selectedBackgroundColor;

  /// Color de fondo cuando el botón está **no seleccionado**.
  ///
  /// Por defecto es `Colors.white`. Debe contrastar con [unselectedRippleColor]
  /// para un efecto visual óptimo.
  final Color unselectedBackgroundColor;

  /// Color del círculo de ripple al transicionar **hacia** el estado seleccionado.
  ///
  /// Por defecto es `Colors.white`. Este color se expande desde el punto
  /// de toque hasta cubrir completamente el botón.
  final Color selectedRippleColor;

  /// Color del círculo de ripple al transicionar **hacia** el estado no seleccionado.
  ///
  /// Por defecto es `Colors.black`. Este color se expande desde el punto
  /// de toque hasta cubrir completamente el botón.
  final Color unselectedRippleColor;

  /// Callback ejecutado al presionar el botón, **antes** de cambiar el estado.
  ///
  /// Úsalo para ejecutar lógica adicional, logging, haptic feedback, etc.
  /// El cambio de estado visual ocurre automáticamente después.
  final VoidCallback onPressed;

  /// Ancho del botón en píxeles lógicos.
  ///
  /// Por defecto: `120.0`
  final double width;

  /// Alto del botón en píxeles lógicos.
  ///
  /// Por defecto: `48.0`
  final double height;

  /// Radio de redondeo de las esquinas del botón.
  ///
  /// **Debe ser al menos 2.0** para un renderizado correcto del clip.
  /// Para un botón circular completo, usa `height / 2` o `width / 2`.
  ///
  /// Por defecto: `2.0`
  final double borderRadius;

  /// Duración de la animación del efecto ripple.
  ///
  /// Controla qué tan rápido se expande el círculo desde el punto de toque
  /// hasta cubrir el botón completo.
  ///
  /// Por defecto: `Duration(milliseconds: 300)`
  final Duration animationDuration;

  /// Controla el estado del botón externamente (opcional).
  ///
  /// - `true`: El botón muestra [selectedChild] y [selectedBackgroundColor].
  /// - `false`: El botón muestra [unselectedChild] y [unselectedBackgroundColor].
  /// - `null`: El botón gestiona su propio estado interno (comienza como no seleccionado).
  ///
  /// **Importante:** Si usas este parámetro, debes actualizar su valor en el
  /// callback [onPressed] usando `setState` en el widget padre.
  final bool? isSelected;

  /// Borde decorativo opcional aplicado al contorno del botón.
  ///
  /// No afecta el área táctil ni el comportamiento del ripple.
  /// Útil para resaltar el botón o darle un estilo premium.
  ///
  /// Ejemplo:
  /// ```dart
  /// border: Border.all(color: Colors.amber, width: 2)
  /// ```
  final BoxBorder? border;

  /// Espaciado interno entre el borde del botón y su contenido.
  ///
  /// Por defecto: `EdgeInsets.symmetric(horizontal: 16)`
  final EdgeInsetsGeometry padding;

  /// Alineación del contenido dentro del botón.
  ///
  /// Por defecto: `Alignment.center`
  final AlignmentGeometry alignment;

  @override
  State<RippleRevealButton> createState() => _RippleRevealButtonState();
}

class _RippleRevealButtonState extends State<RippleRevealButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSelected = false;
  Offset? _tapOrigin;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected ?? false;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward(from: 1.0);
  }

  @override
  void didUpdateWidget(RippleRevealButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != null && oldWidget.isSelected != widget.isSelected) {
      setState(() {
        _isSelected = widget.isSelected!;
      });
    }
    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonWidth = constraints.maxWidth;
          final buttonHeight = widget.height;

          final currentBackgroundColor = _isSelected ? widget.selectedBackgroundColor : widget.unselectedBackgroundColor;
          final rippleColor = _isSelected ? widget.selectedRippleColor : widget.unselectedRippleColor;
          final currentChild = _isSelected ? widget.selectedChild : widget.unselectedChild ?? widget.selectedChild;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTapDown: (details) {
                final box = context.findRenderObject() as RenderBox;
                _tapOrigin = box.globalToLocal(details.globalPosition);
              },
              onTap: () async {
                widget.onPressed();

                if (widget.isSelected == null) {
                  setState(() => _isSelected = !_isSelected);
                }

                await _controller.forward(from: 0);
                _controller.stop();
                _tapOrigin = null;
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: currentBackgroundColor,
                      ),
                    ),

                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        if (_controller.isDismissed) {
                          return const SizedBox.shrink();
                        }

                        final origin = _tapOrigin ?? Offset(buttonWidth / 2, buttonHeight / 2);
                        final maxDiameter = _calculateMaxDiameter(origin, buttonWidth, buttonHeight);
                        final currentDiameter = _animation.value * maxDiameter;

                        return CustomPaint(
                          painter: _RippleCirclePainter(
                            center: origin,
                            diameter: currentDiameter,
                            color: rippleColor,
                          ),
                          size: Size(buttonWidth, buttonHeight),
                        );
                      },
                    ),

                    Positioned.fill(
                      child: Align(
                        alignment: widget.alignment,
                        child: Padding(
                          padding: widget.padding,
                          child: currentChild,
                        ),
                      ),
                    ),

                    if (widget.border != null)
                      IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            border: widget.border,
                            borderRadius: BorderRadius.circular(widget.borderRadius),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Calcula el diámetro necesario para que el círculo cubra completamente el botón
  /// desde cualquier punto de origen [tapPoint].
  double _calculateMaxDiameter(Offset tapPoint, double width, double height) {
    final corners = [
      const Offset(0, 0),
      Offset(width, 0),
      Offset(0, height),
      Offset(width, height),
    ];

    final maxDistance = corners.map((corner) => (corner - tapPoint).distance).reduce((a, b) => a > b ? a : b);

    return maxDistance * 2 + 4;
  }
}

/// Painter personalizado que dibuja el círculo del efecto ripple.
///
/// Se expande desde [center] con un [diameter] específico usando [color].
class _RippleCirclePainter extends CustomPainter {
  const _RippleCirclePainter({
    required this.center,
    required this.diameter,
    required this.color,
  });

  /// Centro del círculo en coordenadas locales del widget.
  final Offset center;

  /// Diámetro actual del círculo durante la animación.
  final double diameter;

  /// Color del círculo de ripple.
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawCircle(center, diameter / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _RippleCirclePainter oldDelegate) {
    return oldDelegate.center != center || oldDelegate.diameter != diameter || oldDelegate.color != color;
  }
}
