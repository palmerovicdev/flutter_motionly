import 'package:flutter/material.dart';

/// Controlador para [DotsIndicator] que permite cambiar el dot activo desde fuera.
///
/// Usa un [ValueNotifier] internamente para sincronizar cambios entre el
/// widget y código externo (ej. paginación manual, scroll listener, etc.).
///
/// ### Ejemplo básico
/// ```dart
/// final controller = DotsIndicatorController(initialIndex: 0);
///
/// DotsIndicator(
///   numberOfDots: 5,
///   controller: controller,
/// )
///
/// // Cambia el dot activo programáticamente
/// controller.jumpTo(2);
/// ```
///
/// **Importante**: Llama a [dispose] cuando ya no necesites el controlador
/// para liberar recursos.
class DotsIndicatorController {
  /// Crea un controlador con un índice inicial opcional.
  ///
  /// Por defecto comienza en el índice 0.
  DotsIndicatorController([int initialIndex = 0]) : index = ValueNotifier<int>(initialIndex);

  /// Notificador del índice actual del dot activo.
  ///
  /// Puedes escuchar cambios con `index.addListener(...)` o leer
  /// el valor directamente con `index.value`.
  final ValueNotifier<int> index;

  /// Obtiene el índice actual del dot activo.
  int get value => index.value;

  /// Salta al índice especificado.
  ///
  /// Este cambio será reflejado automáticamente en el [DotsIndicator]
  /// asociado si está dentro del rango válido.
  void jumpTo(int newIndex) => index.value = newIndex;

  /// Libera los recursos del controlador.
  ///
  /// Llama este método cuando el controlador ya no sea necesario.
  void dispose() => index.dispose();
}

/// Indicador de puntos (dots) animado con transiciones suaves.
///
/// Muestra una fila de puntos donde uno está **activo** (expandido y coloreado)
/// y el resto están **inactivos** (pequeños y atenuados). Ideal para paginación,
/// onboarding, carruseles de imágenes o cualquier flujo de pasos.
///
/// ### Características principales
///
/// - **Animación suave** entre dots con curvas personalizables
/// - **Control externo** opcional vía [DotsIndicatorController]
/// - **Interacción directa**: tap en cualquier dot para saltar a ese índice
/// - **Botones prev/next** opcionales con iconos personalizables
/// - **Fondo contenedor** configurable con color y radio
/// - **Callbacks** para reaccionar a cambios de índice
///
/// ### Modos de operación
///
/// 1. **Interno** (sin controlador): El widget maneja su propio estado.
///    Ideal para casos simples donde no necesitas sincronización externa.
///
/// 2. **Controlado** (con [DotsIndicatorController]): Sincroniza el índice
///    activo con un controlador externo. Perfecto para paginación manual,
///    [PageView], scroll listeners, etc.
///
/// ### UX/Consejos
///
/// - Mantén `numberOfDots` entre 3–7 para no saturar la UI
/// - Usa contraste alto entre [activeDotColor] e [inactiveDotColor]
/// - [showButtons] es útil para desktop/web donde no hay gestos de swipe
/// - Para look "pill": usa `activeDotSize` ancho (ej. `Size(24, 8)`)
/// - El [backgroundColor] puede crear un contenedor tipo "chip" alrededor
///
/// ---
///
/// ### Ejemplo básico
/// ```dart
/// DotsIndicator(
///   numberOfDots: 5,
///   initialActiveDot: 0,
///   onChangeActiveDot: (index) => print('Dot $index seleccionado'),
/// )
/// ```
///
/// ### Ejemplo con controlador externo
/// ```dart
/// final controller = DotsIndicatorController(0);
///
/// // Sincroniza con PageView
/// PageView.builder(
///   onPageChanged: (index) => controller.jumpTo(index),
///   itemCount: 5,
///   itemBuilder: (context, index) => MyPage(index),
/// )
///
/// DotsIndicator(
///   numberOfDots: 5,
///   controller: controller,
/// )
///
/// // Cambia programáticamente
/// ElevatedButton(
///   onPressed: () => controller.jumpTo(3),
///   child: Text('Ir a página 4'),
/// )
/// ```
///
/// ### Ejemplo personalizado completo
/// ```dart
/// DotsIndicator(
///   numberOfDots: 4,
///   initialActiveDot: 0,
///   activeDotColor: Colors.purple,
///   inactiveDotColor: Colors.purple.withOpacity(0.3),
///   backgroundColor: Colors.purple.withOpacity(0.1),
///   backgroundRadius: 20,
///   activeDotSize: Size(28, 10),
///   inactiveDotSize: Size(10, 10),
///   separation: 6,
///   duration: Duration(milliseconds: 400),
///   curve: Curves.easeInOutCubic,
///   showButtons: true,
///   backButton: Icon(Icons.arrow_back_ios, color: Colors.purple, size: 16),
///   nextButton: Icon(Icons.arrow_forward_ios, color: Colors.purple, size: 16),
///   onChangeActiveDot: (index) => print('Página $index'),
/// )
/// ```
///
/// ### Ejemplo con botones de navegación
/// ```dart
/// DotsIndicator(
///   numberOfDots: 3,
///   showButtons: true,
///   activeDotColor: Colors.blue,
///   onChangeActiveDot: (index) {
///     // Navega a la página correspondiente
///     pageController.animateToPage(index);
///   },
/// )
/// ```
///
/// ### Notas técnicas
///
/// - Usa [AnimatedContainer] internamente para transiciones suaves
/// - El controlador sincroniza cambios bidireccionales (widget ↔ externo)
/// - Los callbacks [onChangeActiveDot] y [changeActiveDot] se invocan en
///   cualquier cambio (tap, botones o controlador)
/// - Los botones prev/next se deshabilitan automáticamente en los extremos
class DotsIndicator extends StatefulWidget {
  /// Crea un [DotsIndicator].
  ///
  /// [numberOfDots] define cuántos puntos se mostrarán en total.
  ///
  /// [initialActiveDot] es el índice del dot activo al inicio (base 0).
  /// Solo se usa si no hay [controller].
  ///
  /// [onChangeActiveDot] callback que se invoca cuando cambia el dot activo,
  /// ya sea por tap, botones o controlador externo.
  ///
  /// [changeActiveDot] callback alternativo/legacy para cambios de dot.
  /// Se recomienda usar [onChangeActiveDot].
  ///
  /// [controller] permite control externo del índice activo. Si se proporciona,
  /// el widget sincroniza su estado con el controlador bidireccionalemente.
  ///
  /// [activeDotColor] color del dot activo. Por defecto usa el primaryColor del tema.
  ///
  /// [inactiveDotColor] color de los dots inactivos. Por defecto gris.
  ///
  /// [backgroundColor] color de fondo del contenedor. Por defecto transparente.
  ///
  /// [curve] curva de animación para las transiciones. Por defecto [Curves.elasticOut].
  ///
  /// [duration] duración de la animación de transición. Por defecto 300ms.
  ///
  /// [inactiveDotSize] tamaño de los dots inactivos. Por defecto `Size(8, 8)`.
  ///
  /// [activeDotSize] tamaño del dot activo. Por defecto `Size(24, 8)` (tipo pill).
  ///
  /// [margin] padding interno del contenedor. Por defecto `EdgeInsets.symmetric(vertical: 12, horizontal: 4)`.
  ///
  /// [backgroundRadius] radio del borde del contenedor. Por defecto 32.
  ///
  /// [separation] espacio horizontal entre dots. Por defecto 4.
  ///
  /// [showButtons] si es true, muestra botones prev/next a los lados. Por defecto false.
  ///
  /// [backButton] widget personalizado para el botón "anterior". Si es null y
  /// [showButtons] es true, usa un icono de chevron izquierdo.
  ///
  /// [nextButton] widget personalizado para el botón "siguiente". Si es null y
  /// [showButtons] es true, usa un icono de chevron derecho.
  ///
  /// ### Ejemplo básico
  /// ```dart
  /// DotsIndicator(
  ///   numberOfDots: 5,
  ///   initialActiveDot: 0,
  ///   onChangeActiveDot: (index) => print('Dot $index'),
  /// )
  /// ```
  ///
  /// ### Ejemplo con controlador
  /// ```dart
  /// final controller = DotsIndicatorController(0);
  ///
  /// DotsIndicator(
  ///   numberOfDots: 5,
  ///   controller: controller,
  /// )
  ///
  /// // Más tarde...
  /// controller.jumpTo(3);
  /// ```
  const DotsIndicator({
    super.key,
    this.numberOfDots = 4,
    this.initialActiveDot = 0,
    this.onChangeActiveDot,
    this.changeActiveDot,
    this.activeDotColor,
    this.inactiveDotColor,
    this.backgroundColor,
    this.curve,
    this.duration,
    this.inactiveDotSize,
    this.activeDotSize,
    this.margin,
    this.backgroundRadius,
    this.separation = 4.0,
    this.showButtons = false,
    this.backButton,
    this.nextButton,
    this.controller,
    this.height,
  });

  /// Número total de puntos/dots a mostrar.
  final int numberOfDots;

  /// Altura del widget.
  final double? height;

  /// Índice del dot activo al inicio (base 0).
  ///
  /// Solo se usa si no hay [controller]. Rango válido: 0 a [numberOfDots] - 1.
  final int initialActiveDot;

  /// Callback invocado cuando cambia el dot activo.
  ///
  /// Recibe el nuevo índice como parámetro.
  /// Se invoca por tap directo, botones prev/next o cambios del [controller].
  final ValueChanged<int>? onChangeActiveDot;

  /// Callback alternativo para cambios de dot (legacy).
  ///
  /// Se recomienda usar [onChangeActiveDot] en su lugar.
  final ValueChanged<int>? changeActiveDot;

  /// Color del dot activo.
  ///
  /// Si es null, usa `Theme.of(context).primaryColor`.
  final Color? activeDotColor;

  /// Color de los dots inactivos.
  ///
  /// Si es null, usa `Colors.grey`.
  final Color? inactiveDotColor;

  /// Curva de animación para las transiciones.
  ///
  /// Por defecto [Curves.elasticOut] para un efecto elástico suave.
  final Curve? curve;

  /// Duración de la animación de transición.
  ///
  /// Por defecto 300 milisegundos.
  final Duration? duration;

  /// Tamaño de los dots inactivos.
  ///
  /// Por defecto `Size(8, 8)` (círculo pequeño).
  final Size? inactiveDotSize;

  /// Tamaño del dot activo.
  ///
  /// Por defecto `Size(24, 8)` para efecto "pill" horizontal.
  final Size? activeDotSize;

  /// Color de fondo del contenedor.
  ///
  /// Por defecto transparente. Útil para crear un "chip" alrededor de los dots.
  final Color? backgroundColor;

  /// Padding interno del contenedor.
  ///
  /// Por defecto `EdgeInsets.symmetric(vertical: 12, horizontal: 4)`.
  final EdgeInsetsGeometry? margin;

  /// Radio del borde del contenedor de fondo.
  ///
  /// Por defecto 32. Solo visible si [backgroundColor] no es transparente.
  final double? backgroundRadius;

  /// Espacio horizontal entre dots.
  ///
  /// Por defecto 4 píxeles.
  final double separation;

  /// Si es true, muestra botones de navegación prev/next.
  ///
  /// Por defecto false. Los botones se deshabilitan automáticamente en los extremos.
  final bool showButtons;

  /// Widget personalizado para el botón "anterior".
  ///
  /// Si es null y [showButtons] es true, usa un icono chevron izquierdo.
  final Widget? backButton;

  /// Widget personalizado para el botón "siguiente".
  ///
  /// Si es null y [showButtons] es true, usa un icono chevron derecho.
  final Widget? nextButton;

  /// Controlador opcional para sincronización externa.
  ///
  /// Permite cambiar el dot activo programáticamente desde fuera del widget.
  /// Ver [DotsIndicatorController] para más detalles.
  final DotsIndicatorController? controller;

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  int _currentActiveDot = 0;
  VoidCallback? _controllerListener;

  @override
  void initState() {
    super.initState();
    _currentActiveDot = widget.initialActiveDot;
    _attachController();
  }

  @override
  void didUpdateWidget(covariant DotsIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _detachController(oldWidget.controller);
      _attachController();
    }
  }

  @override
  void dispose() {
    _detachController(widget.controller);
    super.dispose();
  }

  void _attachController() {
    final controller = widget.controller;
    if (controller != null) {
      if (controller.index.value != _currentActiveDot) {
        controller.index.value = _currentActiveDot;
      }
      _controllerListener = () {
        final val = controller.index.value;
        if (val >= 0 && val < widget.numberOfDots && val != _currentActiveDot) {
          setState(() {
            _currentActiveDot = val;
          });
          widget.onChangeActiveDot?.call(val);
          widget.changeActiveDot?.call(val);
        }
      };
      controller.index.addListener(_controllerListener!);
    }
  }

  void _detachController(DotsIndicatorController? controller) {
    if (controller != null && _controllerListener != null) {
      controller.index.removeListener(_controllerListener!);
      _controllerListener = null;
    }
  }

  void _setActive(int newIndex) {
    if (newIndex < 0 || newIndex >= widget.numberOfDots || newIndex == _currentActiveDot) return;

    if (widget.controller != null) {
      widget.controller!.index.value = newIndex;
    } else {
      setState(() {
        _currentActiveDot = newIndex;
      });
      widget.onChangeActiveDot?.call(newIndex);
      widget.changeActiveDot?.call(newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dotButtonSize = ((widget.activeDotSize?.width ?? 48.0) + 12) / 2;

    return SizedBox(
      height: widget.height ?? dotButtonSize * 2,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(widget.backgroundRadius ?? 32.0),
        ),
        child: Padding(
          padding: widget.margin ?? const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showButtons)
                _DotButton(
                  onTap: () => _setActive(_currentActiveDot - 1),
                  child:
                      widget.backButton ??
                      Icon(
                        Icons.chevron_left,
                        color: widget.activeDotColor ?? Theme.of(context).primaryColor,
                        size: dotButtonSize,
                      ),
                ),
              const SizedBox(width: 2.0),
              ...List<Widget>.generate(
                widget.numberOfDots,
                (int index) {
                  final bool isActive = index == _currentActiveDot;
                  return _Dot(
                    isActive: isActive,
                    activeColor: widget.activeDotColor,
                    inactiveColor: widget.inactiveDotColor,
                    curve: widget.curve,
                    duration: widget.duration,
                    inactiveSize: widget.inactiveDotSize,
                    activeSize: widget.activeDotSize,
                    separation: widget.separation,
                    onTap: () => _setActive(index),
                  ).build(context);
                },
              ),
              const SizedBox(width: 2.0),
              if (widget.showButtons)
                _DotButton(
                  onTap: () => _setActive(_currentActiveDot + 1),
                  child:
                      widget.nextButton ??
                      Icon(
                        Icons.chevron_right,
                        color: widget.activeDotColor ?? Theme.of(context).primaryColor,
                        size: dotButtonSize,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DotButton extends StatelessWidget {
  const _DotButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.isActive,
    this.activeColor,
    this.inactiveColor,
    this.curve,
    this.duration,
    this.onTap,
    this.inactiveSize,
    this.activeSize,
    required this.separation,
  });

  final bool isActive;
  final Color? activeColor;
  final Color? inactiveColor;
  final Curve? curve;
  final Duration? duration;
  final VoidCallback? onTap;
  final Size? inactiveSize;
  final Size? activeSize;
  final double separation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: duration ?? const Duration(milliseconds: 300),
          curve: curve ?? Curves.elasticOut,
          margin: EdgeInsets.symmetric(horizontal: separation),
          width: isActive ? activeSize?.width ?? 24.0 : inactiveSize?.width ?? 8.0,
          height: isActive ? activeSize?.height ?? 8.0 : inactiveSize?.height ?? 8.0,
          decoration: BoxDecoration(
            color: isActive ? (activeColor ?? Theme.of(context).primaryColor) : (inactiveColor ?? Colors.grey),
            borderRadius: BorderRadius.circular(activeSize?.width ?? 32.0),
          ),
        ),
      ),
    );
  }
}
