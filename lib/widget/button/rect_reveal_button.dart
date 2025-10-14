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

/// Botón animado con efecto reveal rectangular que alterna entre dos widgets.
///
/// Crea una transición visual suave mediante un efecto de "revelación" rectangular
/// que puede expandirse desde el punto de toque, desde la izquierda o desde la derecha.
///
/// Perfecto para botones de toggle, switches personalizados y elementos interactivos
/// que requieren feedback visual claro del cambio de estado.
///
/// Ejemplo básico:
/// ```dart
/// RectRevealButton(
///   widgetA: Text(
///     'ON',
///     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
///   ),
///   widgetB: Text(
///     'OFF',
///     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
///   ),
///   backgroundColorA: Colors.black,
///   backgroundColorB: Colors.white,
///   rippleColorA: Colors.white,
///   rippleColorB: Colors.black,
///   onPressed: () => print('Toggled!'),
/// )
/// ```
///
/// Ejemplo con dirección personalizada:
/// ```dart
/// RectRevealButton(
///   widgetA: Icon(Icons.favorite, color: Colors.white),
///   widgetB: Icon(Icons.favorite_border, color: Colors.red),
///   backgroundColorA: Colors.red,
///   backgroundColorB: Colors.white,
///   rippleColorA: Colors.red,
///   rippleColorB: Colors.white,
///   revealDirection: RevealDirection.fromLeft,
///   onPressed: () => toggleFavorite(),
///   height: 50,
///   radius: 12,
/// )
/// ```
///
/// Ejemplo con control externo del estado:
/// ```dart
/// class MyWidget extends StatefulWidget {
///   @override
///   State<MyWidget> createState() => _MyWidgetState();
/// }
///
/// class _MyWidgetState extends State<MyWidget> {
///   bool isActive = false;
///
///   @override
///   Widget build(BuildContext context) {
///     return RectRevealButton(
///       selected: isActive,
///       widgetA: Text('Activo'),
///       widgetB: Text('Inactivo'),
///       backgroundColorA: Colors.green,
///       backgroundColorB: Colors.grey,
///       rippleColorA: Colors.green,
///       rippleColorB: Colors.grey,
///       onPressed: () {
///         setState(() => isActive = !isActive);
///       },
///     );
///   }
/// }
/// ```
///
/// Ejemplo con borde personalizado:
/// ```dart
/// RectRevealButton(
///   widgetA: Text('Premium', style: TextStyle(color: Colors.amber)),
///   widgetB: Text('Básico', style: TextStyle(color: Colors.grey)),
///   backgroundColorA: Colors.black,
///   backgroundColorB: Colors.white,
///   rippleColorA: Colors.amber,
///   rippleColorB: Colors.grey,
///   border: Border.all(color: Colors.amber, width: 2),
///   radius: 16,
///   height: 60,
///   onPressed: () => upgradePlan(),
/// )
/// ```
class RectRevealButton extends StatefulWidget {
  /// Crea un [RectRevealButton].
  ///
  /// [widgetA] y [widgetB] son los widgets a mostrar en cada estado (requeridos).
  /// Se recomienda usar estilos contrastantes para mejor visibilidad.
  ///
  /// [backgroundColorA] y [backgroundColorB] son los colores de fondo para cada estado.
  /// Deben ser diferentes para que el efecto sea visible.
  ///
  /// [rippleColorA] y [rippleColorB] son los colores del reveal para cada estado.
  /// Deben ser diferentes para crear el efecto de transición.
  ///
  /// [onPressed] es el callback que se ejecuta al presionar el botón (requerido).
  ///
  /// [revealDirection] controla desde dónde se expande el reveal:
  /// - [RevealDirection.fromClick]: Desde el punto de toque (por defecto)
  /// - [RevealDirection.fromLeft]: Desde la izquierda hacia la derecha
  /// - [RevealDirection.fromRight]: Desde la derecha hacia la izquierda
  ///
  /// [selected] permite control externo del estado del botón (opcional).
  /// Si es null, el botón maneja su propio estado internamente.
  ///
  /// [height] es la altura del botón. Por defecto: 48.0
  ///
  /// [width] es el ancho del botón. Si es null, usa el ancho disponible.
  ///
  /// [radius] es el radio de las esquinas. Mínimo: 2.0. Por defecto: 2.0
  ///
  /// [duration] es la duración de la animación del reveal. Por defecto: 300ms
  ///
  /// [border] es un borde opcional decorativo (no afecta el área de toque).
  ///
  /// [padding] es el padding interno del contenido. Por defecto: horizontal 16px
  ///
  /// [alignment] controla la alineación del contenido. Por defecto: center
  const RectRevealButton({
    super.key,
    required this.widgetA,
    required this.widgetB,
    this.backgroundColorA = Colors.black,
    this.backgroundColorB = Colors.white,
    this.rippleColorA = Colors.white,
    this.rippleColorB = Colors.black,
    required this.onPressed,
    this.height = 48,
    this.width,
    this.radius = 2,
    this.duration = const Duration(milliseconds: 300),
    this.selected,
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = Alignment.center,
    this.revealDirection = RevealDirection.fromClick,
  }) : assert(
         backgroundColorA != backgroundColorB,
         'backgroundColorA y backgroundColorB deben ser diferentes',
       ),
       assert(
         rippleColorA != rippleColorB,
         'rippleColorA y rippleColorB deben ser diferentes',
       ),
       assert(radius >= 2, 'El radio debe ser al menos 2');

  /// Estado inicial del botón (opcional, para control externo).
  ///
  /// Si se proporciona, el botón usará este valor como estado inicial.
  /// Si es null, el botón comienza en estado no seleccionado (false).
  ///
  /// Útil para sincronizar con un estado externo o configuración guardada.
  final bool? selected;

  /// Widget mostrado cuando el botón está en estado seleccionado (true).
  final Widget widgetA;

  /// Widget mostrado cuando el botón está en estado no seleccionado (false).
  final Widget widgetB;

  /// Color de fondo cuando está seleccionado.
  /// Debe ser diferente de [backgroundColorB].
  final Color backgroundColorA;

  /// Color de fondo cuando NO está seleccionado.
  /// Debe ser diferente de [backgroundColorA].
  final Color backgroundColorB;

  /// Color del efecto reveal cuando está seleccionado.
  /// Debe ser diferente de [rippleColorB].
  final Color rippleColorA;

  /// Color del efecto reveal cuando NO está seleccionado.
  /// Debe ser diferente de [rippleColorA].
  final Color rippleColorB;

  /// Callback ejecutado al presionar el botón.
  ///
  /// Se llama antes de que cambie el estado visual del botón.
  final VoidCallback onPressed;

  /// Altura del botón en píxeles.
  ///
  /// Por defecto: 48.0
  final double height;

  /// Ancho del botón en píxeles (opcional).
  ///
  /// Si es null, el botón usará todo el ancho disponible del padre.
  final double? width;

  /// Radio de las esquinas del botón en píxeles.
  ///
  /// Valores más altos crean esquinas más redondeadas.
  /// Mínimo: 2.0. Por defecto: 2.0
  final double radius;

  /// Duración de la animación del reveal.
  ///
  /// Valores más cortos = animación más rápida.
  /// Valores más largos = animación más suave.
  ///
  /// Por defecto: 300 milisegundos
  final Duration duration;

  /// Borde decorativo opcional del botón.
  ///
  /// No afecta el área de toque del botón, solo su apariencia visual.
  ///
  /// Ejemplo:
  /// ```dart
  /// border: Border.all(color: Colors.blue, width: 2)
  /// ```
  final BoxBorder? border;

  /// Padding interno del contenido del botón.
  ///
  /// Por defecto: EdgeInsets.symmetric(horizontal: 16)
  final EdgeInsetsGeometry padding;

  /// Alineación del contenido dentro del botón.
  ///
  /// Por defecto: Alignment.center
  final AlignmentGeometry alignment;

  /// Dirección desde donde se expande el efecto reveal.
  ///
  /// - [RevealDirection.fromClick]: Desde donde el usuario hace tap (dinámico)
  /// - [RevealDirection.fromLeft]: Siempre desde la izquierda
  /// - [RevealDirection.fromRight]: Siempre desde la derecha
  ///
  /// Por defecto: RevealDirection.fromClick
  final RevealDirection revealDirection;

  @override
  State<RectRevealButton> createState() => _RectRevealButtonState();
}

/// Estado del widget [RectRevealButton].
///
/// Maneja el estado de selección, la animación del reveal y la posición del tap.
class _RectRevealButtonState extends State<RectRevealButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _selected = false;
  double _tapX = 0.5;

  @override
  void initState() {
    _selected = widget.selected ?? false;
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward(from: 1.0);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(RectRevealButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _selected = widget.selected ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = widget.width ?? c.maxWidth;
        final h = widget.height;
        final isSelected = _selected;
        final fg = isSelected ? widget.rippleColorA : widget.rippleColorB;
        final bg = isSelected ? widget.backgroundColorA : widget.backgroundColorB;
        final child = isSelected ? widget.widgetB : widget.widgetA;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SizedBox(
            width: widget.width ?? c.maxWidth,
            height: h,
            child: GestureDetector(
              onTapDown: (d) {
                if (widget.revealDirection == RevealDirection.fromClick) {
                  final box = context.findRenderObject() as RenderBox;
                  final localPos = box.globalToLocal(d.globalPosition);
                  var position = localPos.dx / w;
                  _tapX = (position).clamp(0.0, 1.0);
                }
              },
              onTap: () async {
                widget.onPressed();
                setState(() => _selected = !_selected);
                await _ctrl.forward(from: 0);
                _ctrl.stop();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(color: bg),
                        color: bg,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _anim,
                      builder: (_, __) {
                        if (_ctrl.isDismissed || _ctrl.value == 0.0) {
                          return const SizedBox.shrink();
                        }

                        return CustomPaint(
                          painter: _RectRevealPainter(
                            progress: _anim.value,
                            tapX: _tapX,
                            color: fg,
                            direction: widget.revealDirection,
                          ),
                          size: Size(w, h),
                        );
                      },
                    ),
                    Align(
                      alignment: widget.alignment,
                      child: Padding(padding: widget.padding, child: child),
                    ),
                    if (widget.border != null)
                      IgnorePointer(
                        child: Container(
                          decoration: BoxDecoration(
                            border: widget.border,
                            borderRadius: BorderRadius.circular(widget.radius),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Painter personalizado que dibuja el efecto reveal rectangular.
///
/// Dibuja un rectángulo que se expande horizontalmente desde un punto de origen
/// (click, izquierda o derecha) hacia el resto del botón, creando el efecto
/// de revelación suave.
class _RectRevealPainter extends CustomPainter {
  /// Crea un [_RectRevealPainter].
  ///
  /// [progress] es el progreso de la animación de 0.0 (inicio) a 1.0 (completo).
  /// [tapX] es la posición X normalizada del tap (0.0 a 1.0).
  /// [color] es el color del rectángulo que se expande.
  /// [direction] es la dirección del efecto reveal.
  _RectRevealPainter({
    required this.progress,
    required this.tapX,
    required this.color,
    required this.direction,
  });

  /// Progreso de la animación (0.0 a 1.0).
  final double progress;

  /// Posición X normalizada del tap (0.0 = izquierda, 1.0 = derecha).
  final double tapX;

  /// Color del rectángulo reveal.
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
  bool shouldRepaint(covariant _RectRevealPainter old) => old.progress != progress || old.tapX != tapX || old.color != color || old.direction != direction;
}
