import 'package:flutter/material.dart';

/// Botón animado con efecto *ripple/circular reveal* que alterna entre dos widgets.
///
/// Genera un círculo que se expande desde el punto del toque (tap) hasta cubrir
/// el área del botón, creando una transición suave entre dos contenidos
/// (`widgetA` y `widgetB`) y dos esquemas de color (`backgroundColorA/B` y `rippleColorA/B`).
///
/// Es ideal para toggles, switches personalizados y cualquier control donde
/// quieras comunicar el cambio de estado con un feedback visual claro y moderno.
///
/// ### Cómo funciona
/// - El **fondo** del botón cambia entre `backgroundColorA` y `backgroundColorB`
///   según el estado seleccionado.
/// - El **ripple** dibuja un círculo del color `rippleColorA/B` (dependiendo del estado actual)
///   que nace en el punto del tap y se expande hasta cubrir el botón.
/// - El **contenido** alterna entre `widgetA` (estado seleccionado) y `widgetB` (no seleccionado).
///
/// ### Buenas prácticas
/// - Usa **colores contrastantes** entre fondo y ripple para potenciar el efecto.
/// - Ajusta `radius` para esquinas más suaves (mínimo 2.0).
/// - Si vas a controlar el estado desde fuera, usa `selected` y actualízalo en `setState`.
///
/// ---
///
/// ### Ejemplo básico
/// ```dart
/// RippleRevealButton(
///   widgetA: const Text('ON', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
///   widgetB: const Text('OFF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
///   backgroundColorA: Colors.black,
///   backgroundColorB: Colors.white,
///   rippleColorA: Colors.white,
///   rippleColorB: Colors.black,
///   onPressed: () { debugPrint('Toggled!'); },
/// )
/// ```
///
/// ### Ejemplo con personalización visual
/// ```dart
/// RippleRevealButton(
///   widgetA: const Icon(Icons.check, color: Colors.white),
///   widgetB: const Icon(Icons.close, color: Colors.red),
///   backgroundColorA: Colors.green.shade700,
///   backgroundColorB: Colors.grey.shade200,
///   rippleColorA: Colors.greenAccent,
///   rippleColorB: Colors.grey,
///   height: 52,
///   radius: 12,
///   padding: const EdgeInsets.symmetric(horizontal: 20),
///   alignment: Alignment.center,
///   onPressed: () { /* tu lógica */ },
/// )
/// ```
///
/// ### Ejemplo con control externo del estado
/// ```dart
/// class MyToggle extends StatefulWidget {
///   const MyToggle({super.key});
///   @override
///   State<MyToggle> createState() => _MyToggleState();
/// }
///
/// class _MyToggleState extends State<MyToggle> {
///   bool active = false;
///
///   @override
///   Widget build(BuildContext context) {
///     return RippleRevealButton(
///       selected: active,
///       widgetA: const Text('Activo'),
///       widgetB: const Text('Inactivo'),
///       backgroundColorA: Colors.blue,
///       backgroundColorB: Colors.black12,
///       rippleColorA: Colors.white,
///       rippleColorB: Colors.black45,
///       onPressed: () {
///         setState(() => active = !active);
///       },
///     );
///   }
/// }
/// ```
///
/// ### Ejemplo con borde decorativo
/// ```dart
/// RippleRevealButton(
///   widgetA: const Text('Premium', style: TextStyle(color: Colors.amber)),
///   widgetB: const Text('Básico'),
///   backgroundColorA: Colors.black,
///   backgroundColorB: Colors.white,
///   rippleColorA: Colors.amber,
///   rippleColorB: Colors.black,
///   border: Border.all(color: Colors.amber, width: 2),
///   radius: 16,
///   height: 56,
///   onPressed: () { /* upgrade */ },
/// )
/// ```
///
/// ### Notas
/// - Este widget fija el **cursor** a `click` en desktop (`MouseRegion`) para mejor UX.
/// - El ripple nace del **tap exacto** usando coordenadas locales del `RenderBox`.
/// - `duration` controla la velocidad de la expansión circular.
///
class RippleRevealButton extends StatefulWidget {
  /// Crea un [RippleRevealButton].
  ///
  /// [widgetA] y [widgetB] son los widgets a mostrar en cada estado.
  ///
  /// [backgroundColorA] y [backgroundColorB] son los colores de fondo para cada estado.
  /// Deben ser distintos para que el cambio sea perceptible.
  ///
  /// [rippleColorA] y [rippleColorB] son los colores del *ripple* para cada estado.
  /// Deben ser distintos para evitar confusiones visuales.
  ///
  /// [onPressed] se llama al presionar el botón (antes del cambio de estado interno).
  ///
  /// [height], [width], [radius], [duration], [selected], [border],
  /// [padding] y [alignment] son personalizables.
  ///
  /// Se recomienda usar **colores opuestos o muy diferentes** entre A y B
  /// para un resultado visual más claro.
  ///
  /// Ejemplo rápido:
  /// ```dart
  /// RippleRevealButton(
  ///   widgetA: Text('ON'),
  ///   widgetB: Text('OFF'),
  ///   onPressed: () {},
  /// )
  /// ```
  const RippleRevealButton({
    super.key,
    required this.widgetA,
    required this.widgetB,
    this.backgroundColorA = Colors.black,
    this.backgroundColorB = Colors.white,
    this.rippleColorA = Colors.white,
    this.rippleColorB = Colors.black,
    required this.onPressed,
    this.height = 48,
    this.radius = 2,
    this.duration = const Duration(milliseconds: 300),
    this.selected,
    this.border,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.alignment = Alignment.center,
  }) : assert(backgroundColorA != backgroundColorB, 'backgroundColorA and backgroundColorB must be different'),
       // Nota: el mensaje habla de "foregroundColor", pero las props son rippleColorA/B.
       // Si quieres, ajustamos el texto del assert a "rippleColorA and rippleColorB".
       assert(rippleColorA != rippleColorB, 'foregroundColorA and foregroundColorB must be different'),
       assert(radius >= 2, 'radius must be at least 2');

  /// Estado inicial del botón (opcional, control externo).
  ///
  /// - `true`: inicia mostrando `widgetA` y usando `backgroundColorA`/`rippleColorA`.
  /// - `false` o `null`: inicia en no seleccionado, mostrando `widgetB`.
  ///
  /// Si no se provee, el botón gestiona su propio estado interno.
  final bool? selected;

  /// Widget mostrado cuando **está seleccionado**.
  final Widget widgetA;

  /// Widget mostrado cuando **NO** está seleccionado.
  final Widget widgetB;

  /// Color de fondo cuando está seleccionado.
  final Color backgroundColorA;

  /// Color de fondo cuando NO está seleccionado.
  final Color backgroundColorB;

  /// Color del ripple cuando está seleccionado.
  final Color rippleColorA;

  /// Color del ripple cuando NO está seleccionado.
  final Color rippleColorB;

  /// Callback al presionar el botón (se ejecuta antes del cambio interno).
  final VoidCallback onPressed;

  /// Altura del botón en píxeles.
  final double height;

  /// Radio de las esquinas del botón (mínimo 2.0).
  final double radius;

  /// Duración de la animación del ripple.
  final Duration duration;

  /// Borde decorativo opcional (no afecta el área de toque).
  final BoxBorder? border;

  /// Padding interno del contenido.
  final EdgeInsetsGeometry padding;

  /// Alineación del contenido dentro del botón.
  final AlignmentGeometry alignment;

  @override
  State<RippleRevealButton> createState() => _RippleRevealButtonState();
}

class _RippleRevealButtonState extends State<RippleRevealButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _selected = false;
  Offset? _origin;

  @override
  void initState() {
    _selected = widget.selected ?? false;
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _ctrl.forward(from: 1.0);
  }

  @override
  void didUpdateWidget(RippleRevealButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      setState(() {
        _selected = widget.selected ?? false;
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = widget.height;
        final isSelected = _selected;
        final fg = isSelected ? widget.rippleColorA : widget.rippleColorB;
        final bg = isSelected ? widget.backgroundColorA : widget.backgroundColorB;
        final child = isSelected ? widget.widgetA : widget.widgetB;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTapDown: (d) {
              final box = context.findRenderObject() as RenderBox;
              _origin = box.globalToLocal(d.globalPosition);
            },
            onTap: () async {
              widget.onPressed();
              setState(() => _selected = !_selected);
              await _ctrl.forward(from: 0);
              _ctrl.stop();
              _origin = null;
            },
            child: SizedBox(
              width: c.maxWidth,
              height: h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: (c.maxWidth) - 1,
                        decoration: BoxDecoration(
                          color: bg,
                        ),
                      ),
                    ),

                    AnimatedBuilder(
                      animation: _anim,
                      builder: (_, __) {
                        if (_ctrl.isDismissed) return const SizedBox.shrink();

                        final o = _origin ?? Offset(w / 2, h / 2);
                        final maxDia = _diameterToCover(o, w, h);
                        final dia = _anim.value * (maxDia + 1);

                        return CustomPaint(
                          painter: _CirclePainter(
                            center: o,
                            diameter: dia,
                            color: fg,
                            radius: widget.radius,
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

/// Painter que dibuja el círculo del efecto *ripple*.
/// Se expande desde [center] hasta cubrir el botón, con color [color].
class _CirclePainter extends CustomPainter {
  _CirclePainter({
    required this.center,
    required this.diameter,
    required this.color,
    required this.radius,
  });

  /// Centro del círculo (en coordenadas locales del widget).
  final Offset center;

  /// Diámetro actual del círculo.
  final double diameter;

  /// Color del círculo.
  final Color color;

  /// Radio de las esquinas del botón (para consistencia visual si luego
  /// se quisiera recortar/ajustar).
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..color = color;
    canvas.drawCircle(center, diameter / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _CirclePainter old) => old.center != center || old.diameter != diameter || old.color != color;
}

/// Calcula el diámetro necesario para cubrir por completo el botón
/// desde un punto [o], considerando ancho [w] y alto [h].
double _diameterToCover(Offset o, double w, double h) {
  final corners = <Offset>[
    const Offset(0, 0),
    Offset(w, 0),
    Offset(0, h),
    Offset(w, h),
  ];
  final maxDist = corners.map((c) => (c - o).distance).reduce((a, b) => a > b ? a : b);
  return maxDist * 2 + 2;
}
