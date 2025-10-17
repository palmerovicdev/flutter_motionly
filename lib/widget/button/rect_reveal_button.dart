import 'package:flutter/material.dart';

/// Dirección del efecto reveal rectangular.
enum RevealDirection {
  /// El reveal se expande desde el punto donde se hizo clic hacia ambos lados.
  /// Crea un efecto dinámico que responde a la posición del tap.
  fromClick,

  /// El reveal se expande desde la izquierda hacia la derecha.
  /// Útil para indicar progresión o activación.
  fromLeft,

  /// El reveal se expande desde la derecha hacia la izquierda.
  /// Útil para indicar desactivación o retroceso.
  fromRight,
}

/// Botón animado con efecto *reveal rectangular* que alterna entre dos estados.
///
/// Genera una transición rectangular que se expande desde un punto (click, izquierda o derecha)
/// hasta cubrir el área del botón, creando una transición suave entre dos contenidos
/// y dos esquemas de color.
///
/// **Ideal para:** toggles horizontales, switches deslizantes, botones de activación/desactivación,
/// y cualquier control que requiera feedback visual direccional.
///
/// ## Cómo funciona
///
/// - El **fondo** alterna entre `selectedBackgroundColor` y `unselectedBackgroundColor`.
/// - El **reveal** dibuja un rectángulo del color correspondiente al estado destino.
/// - El **contenido** alterna entre `selectedChild` (seleccionado) y `unselectedChild` (no seleccionado).
/// - La **dirección** puede ser desde el click, desde la izquierda o desde la derecha.
///
/// ## Anatomía del efecto
///
/// ```
/// Estado inicial: NO SELECCIONADO
/// ┌─────────────────────┐
/// │  unselectedChild    │  ← Fondo: unselectedBackgroundColor
/// └─────────────────────┘
///
/// Al tocar (fromClick):
/// ┌─────────────────────┐
/// │    ▌████████▐        │  ← Rectángulo expandiéndose (selectedRippleColor)
/// └─────────────────────┘
///
/// Al tocar (fromLeft):
/// ┌─────────────────────┐
/// │███████              │  ← Rectángulo desde izquierda
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
/// - Usa **colores contrastantes** entre fondo y reveal para maximizar el impacto visual.
/// - Asegúrate de que `selectedChild` y `unselectedChild` sean visualmente distintos.
/// - Para esquinas suaves, incrementa `borderRadius` (mínimo 2.0).
/// - Si controlas el estado externamente, usa `isSelected` y actualízalo con `setState`.
/// - Usa `RevealDirection.fromLeft` o `fromRight` para indicar dirección de activación/desactivación.
///
/// ## Ejemplos
///
/// ### Ejemplo básico (toggle ON/OFF)
/// ```dart
/// RectRevealButton(
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
/// ### Ejemplo con iconos y dirección desde la izquierda
/// ```dart
/// RectRevealButton(
///   selectedChild: const Icon(Icons.favorite, color: Colors.white),
///   unselectedChild: const Icon(Icons.favorite_border, color: Colors.red),
///   selectedBackgroundColor: Colors.red,
///   unselectedBackgroundColor: Colors.grey.shade100,
///   selectedRippleColor: Colors.red,
///   unselectedRippleColor: Colors.grey.shade300,
///   revealDirection: RevealDirection.fromLeft,
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
///     return RectRevealButton(
///       isSelected: _isActive,
///       selectedChild: const Text('Activo'),
///       unselectedChild: const Text('Inactivo'),
///       selectedBackgroundColor: Colors.blue,
///       unselectedBackgroundColor: Colors.grey.shade200,
///       selectedRippleColor: Colors.blue,
///       unselectedRippleColor: Colors.grey,
///       revealDirection: RevealDirection.fromLeft,
///       onPressed: () => setState(() => _isActive = !_isActive),
///     );
///   }
/// }
/// ```
///
/// ### Ejemplo con borde decorativo y dirección desde la derecha
/// ```dart
/// RectRevealButton(
///   selectedChild: const Text(
///     'Premium',
///     style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
///   ),
///   unselectedChild: const Text('Básico'),
///   selectedBackgroundColor: Colors.black,
///   unselectedBackgroundColor: Colors.white,
///   selectedRippleColor: Colors.amber,
///   unselectedRippleColor: Colors.black,
///   revealDirection: RevealDirection.fromRight,
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
/// - El reveal puede expanderse desde: el punto de tap, la izquierda o la derecha.
/// - `animationDuration` controla la velocidad de la expansión rectangular.
/// - El widget es completamente responsivo y se adapta al tamaño disponible.
///
class RectRevealButton extends StatefulWidget {
  /// Crea un [RectRevealButton] con efecto de reveal rectangular.
  ///
  /// **Parámetros requeridos:**
  /// - [selectedChild]: Widget mostrado cuando el botón está seleccionado.
  /// - [unselectedChild]: Widget mostrado cuando el botón NO está seleccionado.
  /// - [onPressed]: Callback ejecutado al presionar el botón.
  ///
  /// **Personalización de colores:**
  /// - [selectedBackgroundColor]: Color de fondo en estado seleccionado (por defecto: negro).
  /// - [unselectedBackgroundColor]: Color de fondo en estado no seleccionado (por defecto: blanco).
  /// - [selectedRippleColor]: Color del reveal hacia estado seleccionado (por defecto: blanco).
  /// - [unselectedRippleColor]: Color del reveal hacia estado no seleccionado (por defecto: negro).
  ///
  /// **Dimensiones y apariencia:**
  /// - [width]: Ancho del botón (por defecto: 120).
  /// - [height]: Alto del botón (por defecto: 48).
  /// - [borderRadius]: Radio de las esquinas, mínimo 2.0 (por defecto: 2).
  /// - [border]: Borde decorativo opcional.
  /// - [padding]: Espaciado interno del contenido (por defecto: horizontal 16).
  /// - [alignment]: Alineación del contenido (por defecto: centrado).
  ///
  /// **Control de estado y animación:**
  /// - [isSelected]: Controla el estado desde el widget padre. Si no se provee,
  ///   el botón gestiona su propio estado interno.
  /// - [animationDuration]: Duración de la animación (por defecto: 300ms).
  /// - [revealDirection]: Dirección del efecto reveal (por defecto: desde el click).
  ///
  /// **Ejemplo:**
  /// ```dart
  /// RectRevealButton(
  ///   selectedChild: const Icon(Icons.check),
  ///   unselectedChild: const Icon(Icons.close),
  ///   revealDirection: RevealDirection.fromLeft,
  ///   onPressed: () => print('Pulsado'),
  /// )
  /// ```
  const RectRevealButton({
    super.key,
    required this.selectedChild,
    this.unselectedChild,
    required this.onPressed,
    this.selectedBackgroundColor = Colors.black,
    this.unselectedBackgroundColor = Colors.white,
    this.selectedRippleColor = Colors.white,
    this.unselectedRippleColor = Colors.black,
    this.width = 120,
    this.height = 48,
    this.borderRadius = 2,
    this.animationDuration = const Duration(milliseconds: 300),
    this.isSelected,
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = Alignment.center,
    this.revealDirection = RevealDirection.fromClick,
  }) : assert(borderRadius >= 2, 'borderRadius debe ser al menos 2.0 para un renderizado correcto');

  /// Widget mostrado cuando el botón está en estado **seleccionado**.
  ///
  /// Aparece junto con [selectedBackgroundColor] después de la animación del reveal.
  final Widget selectedChild;

  /// Widget mostrado cuando el botón está en estado **no seleccionado**.
  ///
  /// Aparece junto con [unselectedBackgroundColor] después de la animación del reveal.
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

  /// Color del rectángulo de reveal al transicionar **hacia** el estado seleccionado.
  ///
  /// Por defecto es `Colors.white`. Este color se expande desde el punto
  /// de origen (según [revealDirection]) hasta cubrir completamente el botón.
  final Color selectedRippleColor;

  /// Color del rectángulo de reveal al transicionar **hacia** el estado no seleccionado.
  ///
  /// Por defecto es `Colors.black`. Este color se expande desde el punto
  /// de origen (según [revealDirection]) hasta cubrir completamente el botón.
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

  /// Duración de la animación del efecto reveal.
  ///
  /// Controla qué tan rápido se expande el rectángulo desde el punto de origen
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
  /// No afecta el área táctil ni el comportamiento del reveal.
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

  /// Dirección desde donde se expande el efecto reveal.
  ///
  /// - [RevealDirection.fromClick]: Desde donde el usuario hace tap (dinámico).
  ///   El reveal se expande hacia ambos lados desde el punto de toque.
  /// - [RevealDirection.fromLeft]: Siempre desde la izquierda hacia la derecha.
  ///   Útil para indicar progresión o activación.
  /// - [RevealDirection.fromRight]: Siempre desde la derecha hacia la izquierda.
  ///   Útil para indicar desactivación o retroceso.
  ///
  /// Por defecto: `RevealDirection.fromClick`
  final RevealDirection revealDirection;

  @override
  State<RectRevealButton> createState() => _RectRevealButtonState();
}

class _RectRevealButtonState extends State<RectRevealButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSelected = false;
  double _tapX = 0.5;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected ?? false;
    _controller = AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward(from: 1.0);
  }

  @override
  void didUpdateWidget(RectRevealButton oldWidget) {
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
          final rippleColor = _isSelected ? widget.unselectedRippleColor : widget.selectedRippleColor;
          final currentChild = _isSelected ? widget.selectedChild : widget.unselectedChild ?? widget.selectedChild;

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTapDown: (details) {
                if (widget.revealDirection == RevealDirection.fromClick) {
                  final box = context.findRenderObject() as RenderBox;
                  final localPosition = box.globalToLocal(details.globalPosition);
                  _tapX = (localPosition.dx / buttonWidth).clamp(0.0, 1.0);
                }
              },
              onTap: () async {
                widget.onPressed();

                if (widget.isSelected == null) {
                  setState(() => _isSelected = !_isSelected);
                }

                await _controller.forward(from: 0);
                _controller.stop();
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

                        return CustomPaint(
                          painter: _RectRevealPainter(
                            progress: _animation.value,
                            tapX: _tapX,
                            color: rippleColor,
                            direction: widget.revealDirection,
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
}

/// Painter personalizado que dibuja el efecto reveal rectangular.
///
/// Se expande horizontalmente desde un punto de origen (según [direction])
/// hasta cubrir completamente el botón con [color].
class _RectRevealPainter extends CustomPainter {
  const _RectRevealPainter({
    required this.progress,
    required this.tapX,
    required this.color,
    required this.direction,
  });

  /// Progreso de la animación (0.0 = inicio, 1.0 = completo).
  final double progress;

  /// Posición X normalizada del tap (0.0 = izquierda, 1.0 = derecha).
  /// Solo se usa cuando [direction] es [RevealDirection.fromClick].
  final double tapX;

  /// Color del rectángulo de reveal.
  final Color color;

  /// Dirección desde donde se expande el reveal.
  final RevealDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0.0) return;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double left, right;

    switch (direction) {
      case RevealDirection.fromLeft:
        left = 0.0;
        right = progress * size.width;
        break;

      case RevealDirection.fromRight:
        left = size.width - (progress * size.width);
        right = size.width;
        break;

      case RevealDirection.fromClick:
        final tapXPixels = tapX * size.width;
        final distanceToLeft = tapXPixels;
        final distanceToRight = size.width - tapXPixels;
        final maxDistance = distanceToLeft > distanceToRight ? distanceToLeft : distanceToRight;
        final currentWidth = progress * maxDistance;

        left = (tapXPixels - currentWidth).clamp(0.0, size.width);
        right = (tapXPixels + currentWidth).clamp(0.0, size.width);
        break;
    }

    final rect = Rect.fromLTRB(left - 1, -1, right + 1, size.height + 1);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _RectRevealPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.tapX != tapX || oldDelegate.color != color || oldDelegate.direction != direction;
  }
}
